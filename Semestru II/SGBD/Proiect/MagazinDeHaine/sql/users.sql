CREATE OR REPLACE PACKAGE AuthenticationExceptions
AS
    username_already_exists EXCEPTION;
    email_already_exists EXCEPTION;
    passwords_dont_match EXCEPTION;
    password_too_weak EXCEPTION;
    email_incorrect EXCEPTION;
    username_too_weak EXCEPTION;
    name_is_too_short EXCEPTION;
    field_is_null EXCEPTION;
    username_or_email_doesnt_exist EXCEPTION;
    password_incorrect EXCEPTION;
    user_doesnt_exist EXCEPTION;

    -- assign for each exception a custom error code
    PRAGMA EXCEPTION_INIT(username_already_exists, -20001);
    PRAGMA EXCEPTION_INIT(email_already_exists, -20002);
    PRAGMA EXCEPTION_INIT(passwords_dont_match, -20003);
    PRAGMA EXCEPTION_INIT(password_too_weak, -20004);
    PRAGMA EXCEPTION_INIT(email_incorrect, -20005);
    PRAGMA EXCEPTION_INIT(username_too_weak, -20006);
    PRAGMA EXCEPTION_INIT(name_is_too_short, -20007);
    PRAGMA EXCEPTION_INIT(field_is_null, -20008);
    PRAGMA EXCEPTION_INIT(username_or_email_doesnt_exist, -20009);
    PRAGMA EXCEPTION_INIT(password_incorrect, -20010);
    PRAGMA EXCEPTION_INIT(password_incorrect, -20011);
END AuthenticationExceptions;
/

create or replace package AuthenticationPackage is
    function authenticationResult (p_success in int, p_userID in int, p_message in varchar2) return varchar2;
    function signUp (p_type in varchar2, p_name in varchar2, p_surname in varchar2, p_username in varchar2, p_email in varchar2, p_password in varchar2, p_passwordRepeat in varchar2, p_address in varchar2, p_country in varchar2) return varchar2;
    function logIn (p_usernameOrEmail in varchar2, p_password in varchar2) return varchar2;
    function isLoggedIn(p_id in int) return varchar2;
    function updateUser (p_id in int, p_type in varchar2, p_name in varchar2, p_surname in varchar2, p_newPassword in varchar2, p_newPasswordRepeat in varchar2, p_address in varchar2, p_country in varchar2, p_currentPassword in varchar2) return varchar2;
    function deleteUser (p_id in int, p_password in varchar2) return varchar2;
end;
/

create or replace package body AuthenticationPackage is
    function authenticationResult (p_success in int, p_userID in int, p_message in varchar2)
    return varchar2 as
    begin
        return utl_lms.format_message('{"success": %s,' ||
               '"id": %s,' ||
               '"message": "%s"}', to_char(p_success), to_char(p_userID), p_message);
    end authenticationResult;


    -- signup(type, name, surname, username, password, email, address, country);
    -- Returns a JSON containing the results
    function signUp (p_type in varchar2, p_name in varchar2, p_surname in varchar2, p_username in varchar2, p_email in varchar2, p_password in varchar2, p_passwordRepeat in varchar2, p_address in varchar2, p_country in varchar2)
    return varchar2 as
        v_nextID int;
        v_exists int;
        PRAGMA AUTONOMOUS_TRANSACTION;
        -- see here why the above is required: https://stackoverflow.com/questions/8729236/solution-to-cannot-perform-a-dml-operation-inside-a-query
    begin
        -- prepare next id
        select max (ID) + 1 into v_nextID from users;

        -- check that I don't get any nulls
        if (p_name is null or p_username is null or p_email is null or p_password is null or p_passwordRepeat is null or p_country is null or p_address is null) then
            raise AuthenticationExceptions.field_is_null;
        end if;

        -- check if name is long enough
        if (length(p_name) < 3) then
            raise AuthenticationExceptions.name_is_too_short;
        end if;

        -- check if passwords match
        if (p_password <> p_passwordRepeat) then
            raise AuthenticationExceptions.passwords_dont_match;
        end if;

        -- check if password is strong enough
        if (length(p_password) < 5) then
            raise AuthenticationExceptions.password_too_weak;
        end if;

        -- check if username is strong enough
        if (length(p_username) < 5) then
            raise AuthenticationExceptions.username_too_weak;
        end if;

        -- check if email is correct
        if (REGEXP_LIKE (p_email, '^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') = false) then
            raise AuthenticationExceptions.email_incorrect;
        end if;

        -- check if username already exists (as an email or username for another user)
        select count(*) into v_exists from users where users.username = p_username or users.email = p_username;
        if (v_exists > 0) then
            raise AuthenticationExceptions.username_already_exists;
        end if;

         -- check if email already exists (as an email or username for another user)
        select count(*) into v_exists from users where users.email = p_email or users.username = p_email;
        if (v_exists > 0) then
            raise AuthenticationExceptions.email_already_exists;
        end if;

        insert into users values (v_nextID, p_type, p_name, p_surname, p_username, p_password, p_email, p_address, p_country);
        COMMIT;
        return authenticationResult(1, v_nextID, 'Success! Inserted user with id: ' || v_nextID);

        EXCEPTION
        WHEN AuthenticationExceptions.username_already_exists then
            return AuthenticationResult(0, -1, 'Username already exists!');
        WHEN AuthenticationExceptions.email_already_exists then
            return AuthenticationResult(0, -1, 'Email already exists!');
        WHEN AuthenticationExceptions.passwords_dont_match then
            return AuthenticationResult(0, -1, 'Passwords don''t match!');
        WHEN AuthenticationExceptions.password_too_weak then
            return AuthenticationResult(0, -1, 'Password is too weak!');
        WHEN AuthenticationExceptions.email_incorrect then
            return AuthenticationResult(0, -1, 'Email is incorrect!');
        WHEN AuthenticationExceptions.username_too_weak then
            return AuthenticationResult(0, -1, 'Username is too weak!');
        WHEN AuthenticationExceptions.name_is_too_short then
            return AuthenticationResult(0, -1, 'Didn''t yo momma give you a better name?');
        WHEN AuthenticationExceptions.field_is_null then
            return AuthenticationResult(0, -1, 'You need to complete all the fields!');
        WHEN OTHERS then
            return AuthenticationResult(0, -1, 'Something went terribly wrong when trying to insert new user into database. Did u try restarting it? ' || to_char (SQLCODE) || ' ' || SUBSTR(SQLERRM, 1, 100));
    end signUp;


    -- logIn(email, username, password);
    function logIn (p_usernameOrEmail in varchar2, p_password in varchar2)
    return varchar2 as
        PRAGMA AUTONOMOUS_TRANSACTION;
        v_exists int;
        v_goodPassword users.password%type;
        v_userID int;
        v_nextLoggedUsersID int;
    begin
        if (p_usernameOrEmail is null or p_password is null) then
            raise AuthenticationExceptions.field_is_null;
        end if;

        select count(*) into v_exists from users where email = p_usernameOrEmail or username = p_usernameOrEmail;
        if (v_exists <> 1) then
            raise AuthenticationExceptions.username_or_email_doesnt_exist;
        end if;

        select password, id into v_goodPassword, v_userID from users where email = p_usernameOrEmail or username = p_usernameOrEmail;
        if (v_goodPassword <> p_password) then
            raise AuthenticationExceptions.password_incorrect;
        end if;

        -- user is now logged in, so we insert his id in the logged_in_users table
        -- the trigger created on the table will automatically log him out after 30 minutes
        select max(id_session) + 1 into v_nextLoggedUsersID from logged_in_users;
        if (v_nextLoggedUsersID is null) then
            v_nextLoggedUsersID := 1;
        end if;
        insert into LOGGED_in_USERS values (v_nextLoggedUsersID, v_userID, sysdate);
        COMMIT;
        return authenticationResult(1, v_userID, 'Successfully logged in!');

        EXCEPTION
        WHEN AuthenticationExceptions.field_is_null then
            return authenticationResult(0, -1, 'How hard can it be to complete both fields?');
        WHEN AuthenticationExceptions.username_or_email_doesnt_exist then
            return authenticationResult(0, -1, 'Username or email doesn''t exist!');
        WHEN AuthenticationExceptions.password_incorrect then
            return authenticationResult(0, -1, 'You got your password wrong, buddy. Trying to steal somebody''s account?!');
        WHEN OTHERS then
            return authenticationResult(0, -1, 'I think our database just exploded: ' || to_char (SQLCODE) || ' ' || SUBSTR(SQLERRM, 1, 100));
    end logIn;


    function isLoggedIn(p_id in int)
    return varchar2 as
        PRAGMA AUTONOMOUS_TRANSACTION;
        v_count int;
        v_lastTimeLoggedIn date;
    BEGIN
        select count(*) into v_count from logged_in_users where id_user = p_id;
        if (v_count = 0) then
            return '{"success": 0, "isLoggedIn": 0}';
        end if;

        -- there is a record for this user
        -- check if more than 30 minutes have passed
        select last_time_logged_in into v_lastTimeLoggedIn from logged_in_users where id_user = p_id;
        if ((sysdate - v_lastTimeLoggedIn) * 24 * 60>= 30) THEN
            delete from logged_in_users where id_user = p_id;
            commit;
            return '{"success": 0, "isLoggedIn": 0}';
        end if;

        return '{"success": 1, "isLoggedIn": 1}';
    end isLoggedIn;

    function deleteUser (p_id in int, p_password in varchar2)
    return varchar2 AS
        PRAGMA AUTONOMOUS_TRANSACTION;
        v_goodPassword users.password%type;
        v_count int;
    BEGIN
        select count(*) into v_count from users where id = p_id;
        if (v_count = 0) then
            return '{"success": 0, "deleted": 0, "message": "User doesn''t exist!"}';
        end if;
        select password into v_goodPassword from users where id = p_id;
        if (v_goodPassword = p_password) then
            -- delete from products where id_producer = p_id;
            -- delete from orders where id_user = p_id;
            delete from users where id = p_id;
            commit;
            return '{"success": 1, "deleted": 1, "message": "User deleted"}';
        end if;

        return '{"success": 0, "deleted": 0, "message": "Password is incorrect!"}';
    END deleteUser;


    function updateUser (p_id in int, p_type in varchar2, p_name in varchar2, p_surname in varchar2, p_newPassword in varchar2, p_newPasswordRepeat in varchar2, p_address in varchar2, p_country in varchar2, p_currentPassword in varchar2)
    return varchar2 as
        PRAGMA AUTONOMOUS_TRANSACTION;
        v_userId int;
        v_goodPassword users.password%type;
        v_username users.username%type;
        v_result varchar2(1024);
        -- see here why the above is required: https://stackoverflow.com/questions/8729236/solution-to-cannot-perform-a-dml-operation-inside-a-query
    begin
        -- check that I don't get any nulls
        if (p_type is null or p_currentPassword is null) then
            raise AuthenticationExceptions.field_is_null;
        end if;

        -- check if user actually exists
        v_userId := -1;
        select id into v_userId from users where id = p_id;
        if (v_userId = -1) then
            raise AuthenticationExceptions.user_doesnt_exist;
        end if;

        -- check that password is correct
        select password into v_goodPassword from users where id = p_id;
        if (p_currentPassword <> v_goodPassword) then
            raise AuthenticationExceptions.password_incorrect;
        end if;

        -- I can now update the user

        -- check if name is long enough
        if (p_name is not null) then
            if (length(p_name) < 3) then
                raise AuthenticationExceptions.name_is_too_short;
            end if;

            update users set name = p_name where id = p_id;
            commit;
        end if;

        -- update surname
        if (p_surname is not null) then
            update users set surname = p_surname where id = p_id;
            commit;
        end if;

        -- update address
        if (p_address is not null) then
            update users set address = p_address where id = p_id;
            commit;
        end if;

        -- update country
        if (p_country is not null) then
            update users set country = p_country where id = p_id;
            commit;
        end if;

        -- update password
        if (p_newPassword is not null and p_newPasswordRepeat is not null) then
            if (p_newPasswordRepeat <> p_newPassword) then
                raise AuthenticationExceptions.passwords_dont_match;
            end if;
            if (length(p_newPassword) < 5) then
                raise AuthenticationExceptions.password_too_weak;
            end if;

            update users set password = p_newPassword where id = p_id;
            commit;
        end if;

        -- everything went well, I'll log in the user again
        select username into v_username from users where id = p_id;
        v_result := logIn(v_username, p_currentPassword);

        -- done
        return authenticationResult(1, v_userId, 'Updated user with success!');

        EXCEPTION
        WHEN AuthenticationExceptions.user_doesnt_exist then
            return AuthenticationResult(0, -1, 'User doesn''t exist!');
        WHEN AuthenticationExceptions.password_incorrect then
            return AuthenticationResult(0, -1, 'Current password is incorrect');
        WHEN AuthenticationExceptions.passwords_dont_match then
            return AuthenticationResult(0, -1, 'Passwords don''t match!');
        WHEN AuthenticationExceptions.password_too_weak then
            return AuthenticationResult(0, -1, 'New password is too weak!');
        WHEN AuthenticationExceptions.name_is_too_short then
            return AuthenticationResult(0, -1, 'Didn''t yo momma give you a better name?');
        WHEN AuthenticationExceptions.field_is_null then
            return AuthenticationResult(0, -1, 'You need to complete all the fields!');
        WHEN OTHERS then
            return AuthenticationResult(0, -1, 'Something went terribly wrong when trying to insert new user into database. Did u try restarting it? ' || to_char (SQLCODE) || ' ' || SUBSTR(SQLERRM, 1, 100));
    end updateUser;
end AuthenticationPackage;
/

create or replace trigger removePreviousUserSessions before insert on logged_in_users
    for each row
    begin
        delete from LOGGED_IN_USERS where ID_USER = :new.id_user;
    end removePreviousUserSessions;
/