create or replace package ProductExceptions as
    product_doesnt_exist exception;
    field_is_null exception;
    delete_unauthorized exception;
    add_product_user_doesnt_exist exception;
    add_product_not_a_company exception;
    add_product_wrong_password exception;

    PRAGMA EXCEPTION_INIT(product_doesnt_exist, -20012);
    PRAGMA EXCEPTION_INIT(field_is_null, -20013);
    PRAGMA EXCEPTION_INIT(delete_unauthorized, -20014);
    PRAGMA EXCEPTION_INIT(add_product_user_doesnt_exist, -20015);
    PRAGMA EXCEPTION_INIT(add_product_not_a_company, -20016);
    PRAGMA EXCEPTION_INIT(add_product_wrong_password, -20017);

end ProductExceptions;
/

create or replace package ReturnTypes as
    type tableOfProductRows is table of products%rowtype;
    type tableOfProductIds is table of products.id%type;
end ReturnTypes;
/

create or replace package ProductsPackage is
    function filterProducts (p_portion in int, p_id_category in INT, p_id_producer in int, p_min_price in int, p_max_price in int, p_min_rating in int, p_color in varchar2, p_size in varchar2, p_material_type in varchar2, p_gender in varchar2) return varchar2;
    function getProductInfo (p_id in int) return varchar2;
    function addProduct(p_id_user in int, p_password in varchar2, p_id_category in int, p_id_producer in int, p_name in varchar2, p_price in int, p_color in varchar2, p_productSize in varchar2, p_materialType in varchar2, p_stock in int, p_gender in varchar2) return varchar2;
    function deleteProduct(p_id in int, p_usernameOrEmail in varchar2, p_password in varchar2) return varchar2;
    function getCategories return varchar2;
    function getProducers return varchar2;
    function getProductsFilters return varchar2;
    function isStockAvailableForProduct(p_id in int) return varchar2;
    function updateStock(p_id in int, p_new_stock in int) return varchar2;
end;
/

create or replace package body ProductsPackage is
    -- only returns the ids for those
    -- there are too many items in the database, so we only return the p_portion of them
    function filterProducts (p_portion in int, p_id_category in INT, p_id_producer in int, p_min_price in int, p_max_price in int, p_min_rating in int, p_color in varchar2, p_size in varchar2, p_material_type in varchar2, p_gender in varchar2)
        return varchar2 as
        v_sql varchar2(1024);
        v_return varchar2(20000);
        v_ids ReturnTypes.tableOfProductIds;
        v_lastIndex int;
        v_startIndex int;
    begin
        v_sql := 'select id from products where 1 = 1';

        -- filter by category
        if (p_id_category is not null) then
            v_sql := v_sql || ' and id_category = ' || p_id_category;
        end if;

        -- filter by producer (this is actually id from the users table)
        if (p_id_producer is not null) then
            v_sql := v_sql || ' and id_producer = ' || p_id_producer;
        end if;

        -- filter by min_price
        if (p_min_price is not null) then
            v_sql := v_sql || ' and price >= ' || to_char (p_min_price);
        end if;

        -- filter by max_price
        if (p_max_price is not null) then
            v_sql := v_sql || ' and price <= ' || to_char (p_max_price);
        end if;

        -- filter by p_min_rating
        if (p_min_rating is not null) then
            v_sql := v_sql || ' and sumOfRatings / numberOfRatings >= ' || to_char (p_min_rating);
        end if;

        -- filter by color
        if (p_color is not null) then
            v_sql := v_sql || ' and color = ''' || p_color|| '''';
        end if;

        -- filter by size
        if (p_size is not null) then
            v_sql := v_sql || ' and productSize = ''' || p_size|| '''';
        end if;

        -- filter by material type
        if (p_material_type is not null) then
            v_sql := v_sql || ' and materialType = ''' || p_material_type|| '''';
        end if;

        -- filter by gender
        if (p_gender is not null) then
            v_sql := v_sql || ' and gender = ''' || p_gender || '''';
        end if;

        execute immediate v_sql bulk collect into v_ids;

        v_return := '[';


        -- only return a portion of the items
        v_startIndex := (p_portion - 1) * 50 + 1;

        if (v_ids.count >= v_startIndex) then
            v_lastIndex := p_portion * 50;
            if (v_lastIndex > v_ids.count) then
                v_lastIndex := v_ids.count;
            end if;

            for i in 1..(v_lastIndex - v_startIndex + 1)
                -- I have a total of (v_lastIndex - v_startIndex + 1) products in the current portion
                loop
                    -- i + v_startIndex - 1 represents the position for the current id from v_ids in this portion
                    v_return := v_return || to_char(v_ids(i + v_startIndex - 1)) || ', ';
                end loop;

            v_return := substr(v_return, 0, length(v_return) - 2); -- get rid of the last ,
        end if;

        v_return := v_return || ']';
        return v_return;

    end filterProducts;

    function getProductInfo (p_id in int)
    return varchar2 as
        v_exists int;
        v_product products%ROWTYPE;
        begin
            select count(*) into v_exists from products where id = p_id;
            if (v_exists = 0) then
                raise ProductExceptions.product_doesnt_exist;
            end if;

            select * into v_product from products where id=p_id;

            return utl_lms.format_message('{"success": 1,' ||
                   '"id": %s,' ||
                                          '"id_category": %s,' ||
                                          '"id_producer": %s,' ||
                                          '"name": "%s",' ||
                                          '"price": %s,' ||
                                          '"rating": %s,' ||
                                          '"color": "%s",' ||
                                          '"productSize": "%s",' ||
                                          '"materialType": "%s",' ||
                                          '"stock": %s,' ||
                                          '"gender": "%s"}', to_char(v_product.id), to_char(v_product.ID_CATEGORY), to_char(v_product.id_producer), v_product.name, to_char(v_product.price), case when (v_product.SUMOFRATINGS is null or v_product.NUMBEROFRATINGS is null) then 'null' else case when (v_product.SUMOFRATINGS / v_product.NUMBEROFRATINGS) < 1.0 then '0' else '' end end || to_char(v_product.SUMOFRATINGS / v_product.NUMBEROFRATINGS), v_product.color, v_product.PRODUCTSIZE, v_product.MATERIALTYPE, to_char(v_product.stock), v_product.gender);

            EXCEPTION
            WHEN ProductExceptions.product_doesnt_exist then
                return '{"success": 0, "message": "Product does not exist!"}';

        end getProductInfo;

    function addProduct(p_id_user in int, p_password in varchar2, p_id_category in int, p_id_producer in int, p_name in varchar2, p_price in int, p_color in varchar2, p_productSize in varchar2, p_materialType in varchar2, p_stock in int, p_gender in varchar2)
    return varchar2 as
        pragma autonomous_transaction;
        v_nextID products.id%type;
        v_exists int;
        v_goodPassword users.password%type;
        begin
            select max(id) + 1 into v_nextID from products;

            -- check that there are not any null
            if (p_id_category is null or p_id_producer is null or p_name is null or p_price is null or p_color is null or p_productSize is null or p_materialType is null or p_stock is null or p_gender is null) then
                raise ProductExceptions.field_is_null;
            end if;

            -- make sure that the user trying to add a new product exists
            select count(*) into v_exists from users where id = p_id_user;
            if (v_exists = 0) then
                raise ProductExceptions.add_product_user_doesnt_exist;
            end if;

            -- if the user is a company
            select count(*) into v_exists from users where id = p_id_user and type = 'company';
            if (v_exists = 0) then
                raise ProductExceptions.add_product_not_a_company;
            end if;

            -- if the password is ok
            select password into v_goodPassword from users where id = p_id_user;
            if (v_goodPassword <> p_password) then
                raise ProductExceptions.add_product_wrong_password;
            end if;

            insert into products values (v_nextID, p_id_category, p_name, p_price, p_id_producer, null, null, null, p_color, p_productSize, p_materialType, p_stock, p_gender);
            commit;

            return '{"success": 1, "id": ' || to_char(v_nextID) || ', "message": "Product added!"}';

            EXCEPTION
            when ProductExceptions.field_is_null then
                return '{"success": 0, "message": "Some of the fields are null!"}';
            when ProductExceptions.add_product_user_doesnt_exist then
                return '{"success": 0, "message": "The user trying to add the product does not exist!"}';
            when ProductExceptions.add_product_not_a_company then
                return '{"success": 0, "message": "The user trying to add the product is not a company!"}';
            when ProductExceptions.add_product_wrong_password then
                return '{"success": 0, "message": "The user trying to add the product has the wrong password!"}';

        end addProduct;

    function deleteProduct(p_id in int, p_usernameOrEmail in varchar2, p_password in varchar2)
    return varchar2 as
        pragma autonomous_transaction;
        v_exists int;
        v_ownerId products.id_producer%type;
        v_idForUsernameOrEmail users.id%type;
        v_goodPassword users.password%type;
        begin
            select count(*) into v_exists from products where id = p_id;
            if (v_exists = 0) then
                raise ProductExceptions.product_doesnt_exist;
            end if;

            -- this is the user that actually has the product, so only he can delete the product
            select id_producer into v_ownerId from products where id = p_id;

            -- this is the id for the user which p_usernameOrEmail claims to be
            select id into v_idForUsernameOrEmail from users where username = p_usernameOrEmail or email = p_usernameOrEmail;

            -- the password for the user
            select password into v_goodPassword from users where username = p_usernameOrEmail or email = p_usernameOrEmail;

            if (v_ownerId <> v_idForUsernameOrEmail) then
                raise ProductExceptions.delete_unauthorized;
                else
                if (p_password <> v_goodPassword) then
                    raise ProductExceptions.delete_unauthorized;
                    else
                    -- everything is okay, I can delete this product
                    delete from products where id = p_id;
                    commit;
                end if;
            end if;

            return '{"success": 1, "message": "Product deleted!"}';


            EXCEPTION
            WHEN ProductExceptions.product_doesnt_exist then
                return '{"success": 0, "message": "Product does not exist!"}';
            WHEN ProductExceptions.delete_unauthorized then
                return '{"success": 0, "message": "You do not own this product or your credentials are wrong!"}';

        end deleteProduct;

    function getCategories
    return varchar2 as
        v_return varchar2(30000);
        v_cat categories%rowtype;
        begin
            v_return := '[';
            for v_cat in (select * from categories)
            loop
                v_return := v_return || '{"id": ' || to_char(v_cat.id) || ', "name": "' || v_cat.NAME || '-' || v_cat.SEASON || '~' || to_char (v_cat.id) || '"},';
            end loop;

            if (length(v_return) > 1) then
                v_return := substr (v_return, 0, length(v_return) - 1);
            end if;
            v_return := v_return || ']';
            return v_return;
        end getCategories;

    function getProducers
    return varchar2 as
        v_return varchar2(30000);
        v_producer users%rowtype;
        begin
            v_return := '[';
            for v_producer in (select * from users where type='company')
            loop
                v_return := v_return || '{"id": ' || to_char(v_producer.id) || ', "name": "' || v_producer.NAME;
                if (v_producer.surname is not null) then
                    v_return := v_return || ' ' || v_producer.surname;
                end if;
                v_return := v_return || '"},';
            end loop;

            if (length(v_return) > 1) then
                v_return := substr (v_return, 0, length(v_return) - 1);
            end if;
            v_return := v_return || ']';
            return v_return;
        end getProducers;

    function getProductsFilters
    return varchar2 as
        v_return varchar2(32000);
        begin

            -- colors
            v_return := '{ "color": [';
            for v_color in (select distinct color from products)
            loop
                if (v_color.color is null or length(v_color.color) = 0) then
                    continue;
                end if;
                v_return := v_return || '"' || v_color.color || '", ';
            end loop;
            v_return := substr (v_return, 1, length(v_return) - 2);

            -- product sizes
            v_return := v_return || '], "product_size": [';
            for v_product_size in (select distinct PRODUCTSIZE from products)
            loop
                v_return := v_return || '"' || v_product_size.productsize || '", ';
            end loop;
            v_return := substr (v_return, 1, length(v_return) - 2);

            -- material types
            v_return := v_return || '], "material_type": [';
            for v_material_type in (select distinct materialtype from products)
            loop
                v_return := v_return || '"' || v_material_type.materialtype || '", ';
            end loop;
            v_return := substr (v_return, 1, length(v_return) - 2);

            -- gender
            v_return := v_return || '], "gender": [';
            for v_gender in (select distinct gender from products)
            loop
                v_return := v_return || '"' || v_gender.gender || '", ';
            end loop;
            v_return := substr (v_return, 1, length(v_return) - 2);
            v_return := v_return || ']';

            -- categories
            v_return := v_return || ', "category": ' || getCategories();

            -- producers
            v_return := v_return || ', "producer": ' || getProducers();

            v_return := v_return || '}';

            return v_return;
        end getProductsFilters;

    function isStockAvailableForProduct(p_id in int)
    return varchar2 as
        v_exists int;
        v_product products%rowtype;
        begin
            select count(*) into v_exists from products where id = p_id;
            if (v_exists = 0) then
                raise ProductExceptions.product_doesnt_exist;
            end if;
            select * into v_product from products where id = p_id;

            return '{"success": 0, "stock": ' || to_char(v_product.stock) || '}';

            EXCEPTION
            when ProductExceptions.product_doesnt_exist then
                return '{"success": 0, "message": "Product does not exist!"}';

        end isStockAvailableForProduct;

    function updateStock(p_id in int, p_new_stock in int)
    return varchar2 as
        pragma autonomous_transaction;
        v_exists int;
        v_product products%rowtype;
        begin
            select count(*) into v_exists from products where id = p_id;
            if (v_exists = 0) then
                raise ProductExceptions.product_doesnt_exist;
            end if;

            update products set stock = p_new_stock where id = p_id;
            commit;
            return '{"success": 0, "message": "Stock updated!"}';

            EXCEPTION
            when ProductExceptions.product_doesnt_exist then
                return '{"success": 0, "message": "Product does not exist!"}';
        end updateStock;
end ProductsPackage;
/