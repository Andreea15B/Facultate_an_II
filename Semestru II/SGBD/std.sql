/*
-- This should be executed as SYS:
-- DON'T USE A SSD FOR STORING THE TABLESPACE FILES !!!

CREATE TABLESPACE tbs_perm_student_file
  DATAFILE 'd:\tbs_perm_student_file.dat' 
    SIZE 50M
    REUSE
    AUTOEXTEND ON NEXT 50M MAXSIZE 2000M
/
    
CREATE TEMPORARY TABLESPACE tbs_temp_student_file
  TEMPFILE 'd:\tbs_temp_student_file.dbf'
    SIZE 50M
    AUTOEXTEND ON
/    

CREATE UNDO TABLESPACE tbs_undo_student_file
  DATAFILE 'd:\tbs_undo_student_file.f'
    SIZE 50M 
    AUTOEXTEND ON
  RETENTION GUARANTEE
/

drop user std;

create user std identified by std;
alter user std default tablespace tbs_perm_student_file quota 1990M on tbs_perm_student_file;

grant connect to std;
grant all privileges to std;


--UP to this point (AS SYS)
*/
--------------------------------------------------------------------------------








DROP TABLE students CASCADE CONSTRAINTS
/
DROP TABLE courses CASCADE CONSTRAINTS
/
DROP TABLE grades CASCADE CONSTRAINTS
/
DROP TABLE instructors CASCADE CONSTRAINTS
/
DROP TABLE didactic CASCADE CONSTRAINTS
/
DROP TABLE friendships CASCADE CONSTRAINTS
/
DROP TABLE studenti CASCADE CONSTRAINTS
/
DROP TABLE cursuri CASCADE CONSTRAINTS
/
DROP TABLE note CASCADE CONSTRAINTS
/
DROP TABLE profesori CASCADE CONSTRAINTS
/
DROP TABLE didactic CASCADE CONSTRAINTS
/
DROP TABLE prieteni CASCADE CONSTRAINTS
/
DROP TABLE alumni CASCADE CONSTRAINTS
/


CREATE TABLE students (
  id INT NOT NULL PRIMARY KEY,
  registration_number VARCHAR2(6) NOT NULL,
  lname VARCHAR2(15) NOT NULL,
  fname VARCHAR2(30) NOT NULL,
  year NUMBER(1),
  groupno CHAR(2),
  scholarship NUMBER(6,2),
  dob DATE,
  email VARCHAR2(40),
  created_at DATE,
  updated_at DATE
)
/


CREATE TABLE courses (
  id INT NOT NULL PRIMARY KEY,
  course_title VARCHAR2(50) NOT NULL,
  year NUMBER(1),
  sem NUMBER(1),
  credits NUMBER(2),
  created_at DATE,
  updated_at DATE
)
/


CREATE TABLE grades (
  id INT NOT NULL PRIMARY KEY,
  id_student INT NOT NULL,
  id_course INT NOT NULL,
  value NUMBER(2),
  grading_date DATE,
  created_at DATE,
  updated_at DATE,
  CONSTRAINT fk_grades_id_student FOREIGN KEY (id_student) REFERENCES students(id),
  CONSTRAINT fk_grades_id_course FOREIGN KEY (id_course) REFERENCES courses(id)
)
/

CREATE TABLE instructors (
  id INT NOT NULL PRIMARY KEY,
  lname VARCHAR2(15) NOT NULL,
  fname VARCHAR2(30) NOT NULL,
  title VARCHAR2(20),
  created_at DATE,
  updated_at DATE
)
/

CREATE TABLE didactic (
  id INT NOT NULL PRIMARY KEY,
  id_instructor INT NOT NULL,
  id_course INT NOT NULL,
  created_at DATE,
  updated_at DATE,
  CONSTRAINT fk_didactic_id_instructor FOREIGN KEY (id_instructor) REFERENCES instructors(id),
  CONSTRAINT fk_didactic_id_course FOREIGN KEY (id_course) REFERENCES courses(id) 
)
/


CREATE TABLE friendships (
  id INT PRIMARY KEY,
  id_student1 INT NOT NULL, 
  id_student2 INT NOT NULL, 
  created_at DATE,
  updated_at DATE,  
  CONSTRAINT fk_friendships_id_student1 FOREIGN KEY (id_student1) REFERENCES students(id),
  CONSTRAINT fk_friendships_id_student2 FOREIGN KEY (id_student2) REFERENCES students(id),
  CONSTRAINT no_duplicates UNIQUE (id_student1, id_student2)
)
/

SET SERVEROUTPUT ON;
DECLARE
  TYPE varr IS VARRAY(1000) OF varchar2(255);
  lista_lname varr := varr('Morrison','Bennett','Brady','Coleman','Ford','Rios','Poole','Walters','Guerrero','Flores','Lee','Miller','Francis','French','Martin','Sherman','Graham','Garner','Maxwell','Estrada','Morales','Owen','Lawson','Benson','Hammond','Greene','Lamb','Castro','Perkins','Hughes','Barnes','Mckenzie','Watts','Anderson','Gregory','Alvarez','Yates','Fowler','Wilkins','Warren','Burns','Boone','Goodwin','Porter','Wheeler','Brock','Howard','Barton','Zimmerman','Hodges','Massey','Norton','Gibson','Strickland','Bell','Robinson','Graves','Craig','Howell','Hunt','Malone','Richards','Murphy','Nash','West','Lloyd','Paul','Fuller','Holloway','Goodman','Ryan','Reeves','Cole','Parker','Cohen','Ingram','Scott','Byrd','Hart','Casey','Franklin','Morgan','Mclaughlin','Lyons','Montgomery','Stephens','Glover','Roberts','Erickson','Allison','Ramos','Holland','Hawkins','Williamson','Edwards','Mccoy','Swanson','Delgado','Ellis','Collins','Boyd','Myers','Nichols','Wood','Rice','Wolfe','Stokes','Ortiz','Haynes','Mccormick','Norman','Knight','Patton','Gomez','Chandler','Henry','Tucker','Kennedy','Day','Gray','Banks','Allen','Clark','Reed','Oliver','Price','Simon','Fox','Copeland','Harrington','Brooks','Ruiz','Taylor','Griffith','Jordan','Ballard','Clarke','Kelley','Waters','Russell','Luna','Becker','Nguyen','Norris','Munoz','Wilson','Todd','Olson','George','Rivera','Williams','White','Torres','Brewer','Mendoza','Alexander','Joseph','Mason','Webster','Higgins','Barnett','Harrison','Bailey','Underwood','Robertson','Watkins','Stone','Quinn','Hicks','Holt','Burgess','Hoffman','Adams','Stevens','Chavez','Wilkerson','Bryan','Sandoval','Greer','Soto','Walsh','Wagner','Vega','Schmidt','Figueroa','Thornton','Diaz','Hamilton','Peters','Sims','Duncan','Rhodes','Carter','Alvarado','Powell','Burton','Osborne','Blake','Palmer','Moore','Dawson','Henderson','Lowe','Peterson','Sanders','Shelton','Lopez','Mckinney','Ferguson','Pierce','Neal','Abbott','Keller','Silva','Stewart','Griffin','Lynch','Bush','Nelson','Townsend','Butler','Webb','Spencer','Mack','Frazier','Gutierrez','Moody','Carroll','Bowman','Little','Guzman','Martinez','Larson','Clayton','Perez','Colon','Daniel','Adkins','Turner','Smith','Tate','Mccarthy','Douglas','Riley','Mills','Briggs','Collier','Perry','Murray','Mullins','Vasquez','Wright','Pearson','Cooper','Lewis','Foster','Mann','Santiago','Santos','Cain','Rodgers','Lambert','Fitzgerald','Hudson','Fletcher','Jennings','Schultz','Bowen','Schwartz','Rose','Hopkins','Doyle','Carr','Saunders','Meyer','Cruz','Roy','Baker','Simpson','Valdez','Newton','Caldwell','Parks','Obrien','Johnson','Weaver','Steele','Thomas','Fisher','Walker','Johnston','Grant','Watson','Reid','Gill','Carson','Simmons','Barrett','Holmes','Wells','Mcdonald','Garza','Cook','Bridges','Cox','Leonard','Klein','Lawrence','Rowe','Quinnteles','Aguilar','Willis','Harmon','Long','Davis','Summers','Davidson','Baldwin','Harper','Patrick','Sanchez','Gonzalez','Lindsey','Miles','Wise','Roberson','Bass','Mcgee','Powers','Richardson','Nunez','Hogan','Gordon','Singleton','Harvey','Wade','Welch','Kelly','Houston','Sutton','Love','Bradley','Jimenez','Floyd','Ortega','Black','Ball','Crawford','Bowers','Hernandez','Tran','Brown','Armstrong','Gilbert','Cummings','Snyder','Hayes','Padilla','Dixon','Hampton','Mathis','Medina','Jenkins','Hill','Jacobs','King','Jefferson','Conner','Chapman','Terry','Christensen','Maldonado','Stanley','Gardner','Fields','Ward','Hunter','Ross','Cannon','Sharp','Manning','Newman','Mitchell','Morris','Morton','Hansen','Ramsey','Garcia','Moss','Vargas','Hale','Wallace','Dennis','Fernandez','Thompson','Huff','Park','Walton','Kim','Chambers');
  lista_fname_fete varr := varr('Bonnie','Louise','Janet','Anna','Jane','Ruth','Ashley','Tina','Joyce','Stephanie','Laura','Virginia','Alice','Margaret','Lori','Sharon','Anne','Emily','Andrea','Elizabeth','Sarah','Rebecca','Ann','Brenda','Jessica','Paula','Jennifer','Diana','Cheryl','Lois','Teresa','Susan','Evelyn','Karen','Wanda','Gloria','Carol','Nicole','Phyllis','Martha','Carolyn','Denise','Heather','Theresa','Marie','Sara','Doris','Cynthia','Joan','Sandra','Kathryn','Julie','Mildred','Jacqueline','Donna','Rose','Dorothy','Debra','Rachel','Diane','Irene','Helen','Jean','Lillian','Patricia','Norma','Kelly','Janice','Frances','Annie','Christine','Michelle','Beverly','Catherine','Melissa','Judith','Lisa','Pamela','Tammy','Kathy','Deborah','Linda','Judy','Kathleen','Angela','Christina','Katherine','Marilyn','Shirley','Maria','Ruby','Mary','Kimberly','Barbara','Nancy','Betty','Amy','Julia','Amanda');
  lista_fname_baieti varr := varr('Alonzo','Lorenzo','Tommy','Levi','Dustin','Angelo','Matthew','Johnny','Andres','Jeffrey','Samuel','Alberto','Leland','Wallace','Loren','Gustavo','Virgil','Dale','Jaime','Gerard','Carlos','Jason','Roy','Harvey','Willard','Rick','Stuart','Cody','Eduardo','Gerardo','Curtis','Aubrey','Sammy','Gene','Toby','Winston','Tony','Charlie','Wm','Joseph','Marty','Johnnie','Earl','Brad','Jonathan','Rex','Cornelius','Eddie','Cesar','Keith','Louis','Micheal','Nicholas','Dwight','Dave','Rodolfo','Warren','Raymond','Shannon','Emmett','George','Moses','Preston','Guillermo','Andrew','Ignacio','Leslie','Ian','Kirk','Amos','Bert','Ronnie','Timmy','Manuel','Tim','Gregory','Mario','Earnest','Luis','Lawrence','Eric','Miguel','Rudy','Albert','Wayne','Colin','Larry','Israel','Salvador','Jorge','Thomas','Alton','Pat','Malcolm','Randolph','Nicolas','Marshall','Francis','Tyrone','Lewis');
  lista_materii_year_1 varr := varr('Logic in Informatics','Mathematics','Introduction to Programming','Computer Architecture and Operating Systems','Operating Systems','Object-Oriented Programming','Fundamental Algebraic of Information','Probabilities and Statistics');
  lista_materii_year_2 varr := varr('Computer Networks','Data Basis','Formal Languages, Automata and Compilers','Graph Algorithms','Web Technologies','Advanced Programming','Software Engineering','DBMS Practice');
  lista_materii_year_3 varr := varr('Automated Learning','Network Security','Artificial Intelligence','Python Programming','Numeric Calculus','Computer graphics','Data Mining','Petri networks and their applications');
  lista_grade_diactice varr := varr('Colaborator','Assistant Lecturer','Lecturer','Associate Professor','Professor');
      
  v_lname VARCHAR2(255);
  v_fname VARCHAR2(255);
  v_fname1 VARCHAR2(255);
  v_fname2 VARCHAR2(255);
  v_matr VARCHAR2(6);
  v_matr_aux VARCHAR2(6);
  v_temp int;
  v_temp1 int;
  v_temp2 int;
  v_temp3 int;
  v_temp_date date;
  v_year int;
  v_groupno varchar2(2);
  v_scholarship int;
  v_dob date;  
  v_email varchar2(40);
BEGIN
  
   DBMS_OUTPUT.PUT_LINE('Adding 1025 students...');
   FOR v_i IN 1..1025 LOOP
      v_lname := lista_lname(TRUNC(DBMS_RANDOM.VALUE(0,lista_lname.count))+1);
      IF (DBMS_RANDOM.VALUE(0,100)<50) THEN      
         v_fname1 := lista_fname_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_fname_fete.count))+1);
         LOOP
            v_fname2 := lista_fname_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_fname_fete.count))+1);
            exit when v_fname1<>v_fname2;
         END LOOP;
       ELSE
         v_fname1 := lista_fname_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_fname_baieti.count))+1);
         LOOP
            v_fname2 := lista_fname_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_fname_baieti.count))+1);
            exit when v_fname1<>v_fname2;
         END LOOP;       
       END IF;
     
     IF (DBMS_RANDOM.VALUE(0,100)<60) THEN  
        IF LENGTH(v_fname1 || ' ' || v_fname2) <= 20 THEN
          v_fname := v_fname1 || ' ' || v_fname2;
        END IF;
        else 
           v_fname:=v_fname1;
      END IF;       
       
      LOOP
         v_matr := FLOOR(DBMS_RANDOM.VALUE(100,999)) || CHR(FLOOR(DBMS_RANDOM.VALUE(65,91))) || CHR(FLOOR(DBMS_RANDOM.VALUE(65,91))) || FLOOR(DBMS_RANDOM.VALUE(0,9));
         select count(*) into v_temp from students where registration_number = v_matr;
         exit when v_temp=0;
      END LOOP;
              
      LOOP      
        v_year := TRUNC(DBMS_RANDOM.VALUE(0,3))+1;
        v_groupno := chr(TRUNC(DBMS_RANDOM.VALUE(0,2))+65) || chr(TRUNC(DBMS_RANDOM.VALUE(0,6))+49);
        select count(*) into v_temp from students where year=v_year and groupno=v_groupno;
        exit when v_temp < 30;
      END LOOP;
      
      v_scholarship := '';
      IF (DBMS_RANDOM.VALUE(0,100)<10) THEN
         v_scholarship := TRUNC(DBMS_RANDOM.VALUE(0,10))*100 + 500;
      END IF;
      
      v_dob := TO_DATE('01-01-1974','MM-DD-YYYY')+TRUNC(DBMS_RANDOM.VALUE(0,365));
      
      v_temp:='';
      v_email := lower(v_lname ||'.'|| v_fname1);
      LOOP         
         select count(*) into v_temp from students where email = v_email||v_temp;
         exit when v_temp=0;
         v_temp :=  TRUNC(DBMS_RANDOM.VALUE(0,100));
      END LOOP;    
      
      if (TRUNC(DBMS_RANDOM.VALUE(0,2))=0) then v_email := v_email ||'@gmail.com';
         else v_email := v_email ||'@info.ro';
      end if;
                      
      --DBMS_OUTPUT.PUT_LINE (v_i||' '||v_matr||' '||v_lname||' '||v_fname ||' '|| v_year ||' '|| v_groupno||' '|| v_scholarship||' '|| to_char(v_dob, 'DD-MM-YYYY')||' '|| v_email);      
      insert into students values(v_i, v_matr, v_lname, v_fname, v_year, v_groupno, v_scholarship, v_dob, v_email, sysdate, sysdate);
   END LOOP;
   DBMS_OUTPUT.PUT_LINE('done !');
   
  
   select count(*) into v_temp from students;
   FOR v_i IN 1..20000 LOOP   
       LOOP
          v_temp1 :=  TRUNC(DBMS_RANDOM.VALUE(0,v_temp-1))+1;
          v_temp2 :=  TRUNC(DBMS_RANDOM.VALUE(0,v_temp-1))+1;
          EXIT WHEN v_temp1<>v_temp2;
       END LOOP;
       DECLARE 
       BEGIN
          --DBMS_OUTPUT.PUT_LINE(v_temp1 || ' ' || v_temp2);
          v_dob := (sysdate-TRUNC(DBMS_RANDOM.VALUE(0,1000)));
          insert into friendships values(v_i, v_temp1, v_temp2, v_dob, v_dob); 
          exception 
             when OTHERS then null;
       END;
   END LOOP;   
      
   
   DBMS_OUTPUT.PUT_LINE('Adding Courses...');
   FOR v_i IN 1..8 LOOP
      IF (v_i<5) THEN v_temp := 1; ELSE v_temp := 2; END IF;
      IF (v_i IN (2,3,6,7)) THEN v_temp1 := 5; END IF; 
      IF (v_i IN (1,5)) THEN v_temp1 := 4; END IF; 
      IF (v_i IN (4,8)) THEN v_temp1 := 6; END IF; 
      insert into courses values (v_i, lista_materii_year_1(v_i), 1, v_temp, v_temp1, sysdate-1200, sysdate-1200);
   END LOOP;
   
   FOR v_i IN 1..8 LOOP
      IF (v_i<5) THEN v_temp := 1; ELSE v_temp := 2; END IF;
      IF (v_i IN (2,3,6,7)) THEN v_temp1 := 5; END IF; 
      IF (v_i IN (1,5)) THEN v_temp1 := 4; END IF; 
      IF (v_i IN (4,8)) THEN v_temp1 := 6; END IF; 
      insert into courses values (v_i+8, lista_materii_year_2(v_i), 2, v_temp, v_temp1, sysdate-1200, sysdate-1200);
   END LOOP;
   
   FOR v_i IN 1..8 LOOP
      IF (v_i<5) THEN v_temp := 1; ELSE v_temp := 2; END IF;
      IF (v_i IN (2,3,6,7)) THEN v_temp1 := 5; END IF; 
      IF (v_i IN (1,5)) THEN v_temp1 := 4; END IF; 
      IF (v_i IN (4,8)) THEN v_temp1 := 6; END IF; 
      insert into courses values (v_i+16, lista_materii_year_3(v_i), 3, v_temp, v_temp1, sysdate-1200, sysdate-1200);
   END LOOP;       
   DBMS_OUTPUT.PUT_LINE('Done !');  
   
   
   DBMS_OUTPUT.PUT_LINE('Adding grades...');
   
   v_temp3 := 1;   
   FOR v_i IN 1..1025 LOOP
       select year into v_temp from students where id = v_i;
       if (v_temp=1) then
          FOR v_temp1 IN 1..8 LOOP
            if (v_temp1 IN (1,2,3,4)) THEN v_temp_date := to_date(to_char(sysdate,'YYYY')||'-01-01','YYYY-MM-DD')+(40+TRUNC(DBMS_RANDOM.VALUE(0,14)))-365;
               ELSE v_temp_date := to_date(to_char(sysdate,'YYYY')||'-01-01','YYYY-MM-DD')+(180+TRUNC(DBMS_RANDOM.VALUE(0,14)))-365;
            END IF;
            insert into grades values (v_temp3, v_i, v_temp1, TRUNC(DBMS_RANDOM.VALUE(0,7)) + 4, v_temp_date, v_temp_date, v_temp_date);
            v_temp3 := v_temp3+1;
          END LOOP;  
       end if;
       if (v_temp=2) then
          FOR v_temp1 IN 1..16 LOOP
            if (v_temp1 IN (1,2,3,4)) THEN v_temp_date := to_date(to_char(sysdate,'YYYY')||'-01-01','YYYY-MM-DD')+(40+TRUNC(DBMS_RANDOM.VALUE(0,14)))-730; END IF;
            if (v_temp1 IN (5,6,7,8)) THEN v_temp_date := to_date(to_char(sysdate,'YYYY')||'-01-01','YYYY-MM-DD')+(180+TRUNC(DBMS_RANDOM.VALUE(0,14)))-730; END IF;          
            if (v_temp1 IN (9,10,11,12)) THEN v_temp_date := to_date(to_char(sysdate,'YYYY')||'-01-01','YYYY-MM-DD')+(40+TRUNC(DBMS_RANDOM.VALUE(0,14)))-365; END IF;
            if (v_temp1 IN (13,14,15,16)) THEN v_temp_date := to_date(to_char(sysdate,'YYYY')||'-01-01','YYYY-MM-DD')+(180+TRUNC(DBMS_RANDOM.VALUE(0,14)))-365; END IF;                                   
            insert into grades values (v_temp3, v_i, v_temp1, TRUNC(DBMS_RANDOM.VALUE(0,6)) + 4, v_temp_date, v_temp_date, v_temp_date);
            v_temp3 := v_temp3+1;
          END LOOP;  
       end if;  
       
       if (v_temp=3) then
          FOR v_temp1 IN 1..24 LOOP
            if (v_temp1 IN (1,2,3,4)) THEN v_temp_date := to_date(to_char(sysdate,'YYYY')||'-01-01','YYYY-MM-DD')+(40+TRUNC(DBMS_RANDOM.VALUE(0,14)))-1095; END IF;
            if (v_temp1 IN (5,6,7,8)) THEN v_temp_date := to_date(to_char(sysdate,'YYYY')||'-01-01','YYYY-MM-DD')+(180+TRUNC(DBMS_RANDOM.VALUE(0,14)))-1095; END IF;          
            if (v_temp1 IN (9,10,11,12)) THEN v_temp_date := to_date(to_char(sysdate,'YYYY')||'-01-01','YYYY-MM-DD')+(40+TRUNC(DBMS_RANDOM.VALUE(0,14)))-730; END IF;
            if (v_temp1 IN (13,14,15,16)) THEN v_temp_date := to_date(to_char(sysdate,'YYYY')||'-01-01','YYYY-MM-DD')+(180+TRUNC(DBMS_RANDOM.VALUE(0,14)))-730; END IF;                                   
            if (v_temp1 IN (17,18,19,20)) THEN v_temp_date := to_date(to_char(sysdate,'YYYY')||'-01-01','YYYY-MM-DD')+(40+TRUNC(DBMS_RANDOM.VALUE(0,14)))-365; END IF;
            if (v_temp1 IN (21,22,23,24)) THEN v_temp_date := to_date(to_char(sysdate,'YYYY')||'-01-01','YYYY-MM-DD')+(180+TRUNC(DBMS_RANDOM.VALUE(0,14)))-365; END IF;                                   
            
            insert into grades values (v_temp3, v_i, v_temp1, TRUNC(DBMS_RANDOM.VALUE(0,7)) + 4, v_temp_date, v_temp_date, v_temp_date);
            v_temp3 := v_temp3+1;
          END LOOP;  
       end if;                
   END LOOP;
   
   DBMS_OUTPUT.PUT_LINE('Done !');
   
   
   DBMS_OUTPUT.PUT_LINE('Adding instructors...');
   
   FOR v_i IN 1..30 LOOP
      v_lname := lista_lname(TRUNC(DBMS_RANDOM.VALUE(0,lista_lname.count))+1);
      IF (DBMS_RANDOM.VALUE(0,100)<50) THEN      
         v_fname1 := lista_fname_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_fname_fete.count))+1);
         LOOP
            v_fname2 := lista_fname_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_fname_fete.count))+1);
            exit when v_fname1<>v_fname2;
         END LOOP;
       ELSE
         v_fname1 := lista_fname_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_fname_baieti.count))+1);
         LOOP
            v_fname2 := lista_fname_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_fname_baieti.count))+1);
            exit when v_fname1<>v_fname2;
         END LOOP;       
       END IF;
       
       IF (DBMS_RANDOM.VALUE(0,100)<60) THEN  
          IF LENGTH(v_fname1 || ' ' || v_fname2) <= 20 THEN
            v_fname := v_fname1 || ' ' || v_fname2;
          END IF;
          else 
             v_fname:=v_fname1;
        END IF;           
        INSERT INTO instructors values (v_i, v_lname, v_fname, lista_grade_diactice(TRUNC(DBMS_RANDOM.VALUE(0,5))+1), sysdate-1000, sysdate-1000);       
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Done !');  
    
    
    DBMS_OUTPUT.PUT_LINE('Adding links between instructors and courses...');
    v_temp3:=1;
    FOR v_i IN 1..24 LOOP
       INSERT INTO didactic values(v_temp3,v_i, v_i, sysdate-1000, sysdate-1000);
       v_temp3:=v_temp3+1;
    END LOOP;
    
    FOR v_i IN 1..50 LOOP
       INSERT INTO didactic values(v_temp3,(TRUNC(DBMS_RANDOM.VALUE(0,30))+1), (TRUNC(DBMS_RANDOM.VALUE(0,24))+1), sysdate-1000, sysdate-1000);
       v_temp3:=v_temp3+1;
    END LOOP;
    
    
    DBMS_OUTPUT.PUT_LINE('Done !');   

    DBMS_OUTPUT.PUT_LINE('English version of this script was made by Mihaita Manolache');    
    
END;
/


select count(*)|| ' students' from students;
select count(*)|| ' instructors' from instructors;
select count(*)|| ' courses' from courses;
select count(*)|| ' grades' from grades;
select count(*)|| ' friendships' from friendships;












select count(*) from (select * from grades g1 join students s1 on g1.ID_STUDENT=s1.ID join friendships F on F.ID_STUDENT1=s1.ID join students s2 on F.ID_STUDENT2=s2.id join grades g2 on g2.id_student=s2.id);
/

drop table fg
/

CREATE TABLE fg (
  ID NUMBER(10) PRIMARY KEY,
  lnameA VARCHAR2(15) NOT NULL,
  fnameA VARCHAR2(30) NOT NULL,
  dobA DATE,
  valueA NUMBER(2),
  lnameB VARCHAR2(15) NOT NULL,
  fnameB VARCHAR2(30) NOT NULL,
  dobB DATE,
  valueB NUMBER(2)
)
/

drop sequence id_seq;
CREATE SEQUENCE id_seq START WITH 1;

CREATE OR REPLACE TRIGGER fg_id_autoinc 
BEFORE INSERT ON fg 
FOR EACH ROW
BEGIN
  SELECT id_seq.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/

-- this will run in like 3 minutes:
insert into fg (lnameA, fnameA, dobA, valueA, lnameB, fnameB, dobB, valueB) select s1.lname, s1.fname, s1.dob, g1.value, s2.lname, s2.fname, s2.dob, g2.value    
from grades g1 join students s1 on g1.ID_STUDENT=s1.ID join friendships F on F.ID_STUDENT1=s1.ID join students s2 on F.ID_STUDENT2=s2.id join grades g2 on g2.id_student=s2.id
/

--update one row (Michael Jackson will be unique)
update fg set lnameA='Jackson', fnameA='Michael' where id=1025;
/








-- any time you need to see the curent indexes, remember that:
-- don;t drop any starting with sys...
select index_name from user_indexes;




-- Why indexes ? because it suck without. Try this (just for not having fun):
-- Step 1:
select * from fg where lnameA='Jackson';
-- how much did it take ? See execution plan !






--------  A: a simple index:
-- Step 1: create an index:
create index idx_lnameA on fg(lnameA);
-- how much did it take ?
-- Step 2: 
select * from fg where lnameA='Jackson';
-- how much did it take ? Why is faster ? See execution plan !
-- Step 3: deleting index
drop index idx_lnameA;







--------- B: primary key is always indexed 
-- Step 1: make a search on PK:
select * from fg where id=9999;
-- how much did it take ? 
-- run this again
-- how much did it take ? Can you explain ?
-- investigate the execution plan







---------- C: index on more columns
-- Step 1: create the index:
create index idx_lnA_grA_lnB_grB on fg(lnameA, valueA, lnameB, valueB);
-- Step 2: ask for all data:
select * from fg where lnameA='Jackson';
-- execute it again (statistics are in place this time)
-- observe the execution plan; can you make a querry on this index that
-- does not use the access into the table (table access (By Ibdex ROWID)) ?
-- Step 3: try this:
select lnameB from fg where lnameA='Jackson';
-- explain why is not accessing the table anymore
-- Step 4: let's find somebody else (all infos):
select * from fg where id=9999;
-- remember the values for: lnameA, valueA, lnameB, valueB;
-- Step 5: Search the same row by fields: lnameA, valueA, lnameB, valueB;
select * from fg where lnameA='...' and valueA=... and lnameB='...' and valueB=...;
-- observe the execution plan !
-- Step 6: for the same row now search it by using lnameA, valueA
select * from fg where lnameA='...' and valueA=...;
-- observe the execution plan !
-- Step 7: for the same row, now search it by using lnameB, valueB
select * from fg where lnameB='...' and valueB=...;
-- observe the execution plan !
-- Step 8: do this (complete the points)
select lnameA, valueA from fg where lnameB='...' and valueB=...;
-- observe the execution plan !
-- Step 9: do this (complete the points)
select lnameB, valueB from fg where lnameA='...' and valueA=...;
-- observe the execution plan !
-- Step 10: clear it:
drop index idx_lnA_grA_lnB_grB;
-- you want to drop this because a simple update (like the next one will run 
-- super slow if you don't - it needs to rebalance the B+ tree after each update)






----------- D: on groups:
-- this updates will take around 6 minutes
update fg set valueB=9 where valueB=8
/
update fg set valueB=9 where valueB=7
/
update fg set valueB=9 where valueB=6
/
update fg set valueB=9 where valueB=5
/
update fg set valueB=9 where valueB=4
/
select count(*) from fg where valueB=10;
update fg set valueB=8 where id=9999;
-- observe the time needed and the execution plan (full table scan)
-- Step 2: let's create the index
create index idx_valueB on fg(valueB);
-- Step 3: do the select again:
select count(*) from fg where valueB=10;
-- execution plan: did it need the table ?
-- Step 4: see the execution plans for:
select * from fg where valueB=11; -- should go on index
select * from fg where valueB=10; -- should go on index
select * from fg where valueB=9; -- if this go on index is the big if
select * from fg where valueB=8; -- index (for sure)
-- Step 5:
drop index idx_valueB;







---------- E: Function based indexes:
-- Step 1:
create index idx_lnameA on fg(lnameA);
-- Step 2: verify that searching for a name go on index:
select * from fg where lnameA='Jackson';
-- check the execution plan (should see the idx_lnameA used)
-- Step 3: try ignoring the case:
select * from fg where upper(lnameA)=upper('Jackson');
-- check the execution plan (remember the cost and how is executed)
-- Step 4: create an function based index:
create index idx_fbi_upper_lnameA on fg(upper(lnameA));
-- Step 5: check the select from step 3 again:
select * from fg where upper(lnameA)=upper('Jackson');
-- check the execution plan (compare with what you wrote down at step 3)
-- Step 6: update Jackson to jackson (in the table) and search again - the
-- FBI will rebalance and pinpoint the record again
update fg set lnameA='jackson' where lnameA='Jackson';
-- even this update has an execution plan.... check it out
-- can you imagine what else has an execution plan except select and update ?
-- Step 7: how does the query from Step 3 or 5 executes now ? how fast ? 
-- [same as in step 3 or as in step 5] - answer before testing
select * from fg where upper(lnameA)=upper('Jackson');
-- Step 8: update it back and drop the index:
update fg set lnameA='Jackson' where lnameA='jackson'
/
drop index idx_lnameA
/
drop index idx_fbi_upper_lnameA
/





--------- F: Search on intervals:
-- Step 1: Let's find out min and max dobA
select min(dobA), max(dobA) from fg;
-- Step 2: Create and index on dobA and on valueA:
create index idx_dobA_valueA on fg(dobA, valueA);
-- Step 3: ask guys who are born in march and got a 10:
select * from fg where dobA between to_date('01-01-1974','DD-MM-YYYY') and to_date('31-01-1974','DD-MM-YYYY') and valueA=10;
-- remember the cost for this operation !!!
-- Step 4: Create and index on valueA and on dobA:
create index idx_valueA_dobA on fg(valueA, dobA);
-- Step 5: ask guys who are born in march and got a 10:
select * from fg where dobA between to_date('01-01-1974','DD-MM-YYYY') and to_date('31-01-1974','DD-MM-YYYY') and valueA=10;
-- compare with the cost from step 3; also observe that the last index is prefered
-- WHEN SEARCHING ON INTERVALS, ALWAYS PUT THE INDEX ON EQUALITY FIRST !
-- Step 6: ok, now drop both indexes:
drop index idx_dobA_valueA
/
drop index idx_valueA_dobA
/





--------- G: Searhing using LIKE
-- Step 1: build an index on the lnameA;
create index idx_lnameA on fg(lnameA);
-- Step 2: Now search for that Jackson dude:
select * from fg where lnameA='Jackson';
-- check out the execution plan (cost and access predicates);
-- Step 3: Now do search for 'Jackson' (but using like)
select * from fg where lnameA like 'Jackson';
-- cost and access should be about the same
-- Step 4: now let's add an '%' in the middle:
select * from fg where lnameA like 'Jac%kson';
-- observe that in the execution plan the cost has doubled and also 
-- the querry has now an access predicates and also some filter predicates. Why ?
-- Move the position of that '%' around and check the execution plan each time:
select * from fg where lnameA like 'Jackso%n'; -- this should be better/faster
select * from fg where lnameA like 'J%ackson'; -- or a bit slower
select * from fg where lnameA like '%Jackson'; -- this should be much much worse
-- also observe that it only filter from table, not using indexes at all.
-- observe both the execution plan and the time needed for the query to be executed
-- Step 5:
-- Drop the index:
drop index idx_lnameA
/
-- Step 6:
-- ok, let's make the '%Jackson' run faster:
create index idx_reverse_lnameA on fg(reverse(lnameA));
-- Step 7: and the query:
select * from fg where reverse(lnameA) like reverse('%Jackson');
-- Step 8: aaaand... drop it:
drop index idx_reverse_lnameA
/





--------- H: NULL in Oracle
--Step 1: WHAT IS NULL IN ORACLE ? : '' is null
select '0 IS NULL ?' as "WHAT IS NULL ?" FROM DUAL WHERE 0 IS NULL 
UNION
select '0 IS NOT NULL ?' as "WHAT IS NULL ?" FROM DUAL WHERE 0 IS NOT NULL 
UNION
select ''''' IS NULL ?' as "WHAT IS NULL ?" FROM DUAL WHERE '' IS NULL 
UNION
select ''''' IS NULL ?' as "WHAT IS NULL ?" FROM DUAL WHERE '' IS NOT NULL 
-- STEP 2: anso NULL is ''
select dummy, dummy||'', dummy||NULL from dual;
-- Step 3: set a null value in some random row:
update fg set valueb='' where id=1000;
-- step 4: try to index it:
create index idx_valueb on fg(valueb);
-- step 5: check out the execution plan for this:
select * from fg where valueb is null;
-- because Oracle will not index null values, you will get a table access(full) - scanning the entire table
-- step6: add a non-null column in the index:
drop index idx_valueb;
create index idx_valueb on fg(valueb, lnameA);
-- we know that lnameA is not null because the table was created this way.
-- step 6: he realizes that lname cannot be null and knows that he added it to the index (the pair null,notnull are added):
select * from fg where valueb is null and lnameA like '';
-- step 7: he uses both predicates in this (valueB is in the index):
select * from fg where valueb is null and lnameA like 'A%'; 
-- step 8: can it be selected individually (from the index?) 
select * from fg where valueb is null; 
-- so, as we can see, adding a not null column on the second position of the index 
-- will allow you to search for the records having null on the first column in the index
-- step 9: can we find the not-null values from index ? 
select * from fg where valueb is not null; 
-- even though all the not-null values are in the indx (and he knows that he can find them there)
-- if the time needed to access by index rowid is greater then scanning the full table, he will
-- choose to ignore the index. (ofc, if you use a SSD he might choose to use the index anyway).
-- you can learn how to trick QO but what he does depends on more than one or two parameters

-- step 10:
-- you might think that the rows where valueB=4 will be identified
-- based on the rowid found in the index. If the number of rows is 
-- too big than QO might prefer to full scan the table:
select * from fg where valueb=4;
-- step 11:
-- however, if you only asks data that are in the index or that can
-- be computed directly from the index, the index will be used:
select valueb from fg where valueb=4;
-- or:
select count(*) from fg where valueb=4;
--step12: as we have seen, all the nulls are now in the index. So, the following query will use it:
select count(*) from fg where valueb is null;
-- what if the lnamea can have nulls ?
--Step 13: update table:
alter table fg modify lnamea null;
-- execute the last query again - will not work, can you explain why (maybe both are null and
-- the row is not indexed anymore).
drop index idx_valueb;








--------- I: Partial indexing in Oracle
-- the main ideea is to create a function based index that returns null where
-- you don;t want the index to store the information
-- Step 1:
-- let's do an index that only indexes rows where valueB = 10. 
-- First compile the following deterministic function:
create or replace function splittable(val IN number) return number deterministic is
begin
   if (val=10) then return val;
   else return null;
   end if;
end;
-- and then create the index:
create index idx_10 on fg(splittable(valueB));
-- this time he will apply the function to each value in the valueB field... 
-- and create an index containing the results
-- step 2: test it:
select count(*) from fg where splittable(valueB)=10; -- will access via index
select count(*) from fg where splittable(valueB)<>10; -- will still go on the index - can you explain why ?
-- Answer: because NULL is interogated with IS NULL (and not with <>), he thinks that you are interested
-- where you actually have a value in there.
-- Step 3: 
select count(*) from fg where splittable(valueB) is null; -- since he doesn't store nulls, he has to use the table
drop index idx_10;
-- step 3: is it possible to make it work on index (the last query?)
create index idx_10 on fg(splittable(valueB),'1'); 
-- now we added a value that will never be null ('1'... can be also 1 or any constant)
-- actually this is the same with indexing an non-null field
select count(*) from fg where splittable(valueB) is null;
drop index idx_valueb;






--------- J: Joins
-- Step 1: let's first create a join that can be used as a testcase in indexing:
select scholarship from fg join students on fg.lnamea=students.lname  where fg.lnamea like 'A%';
-- cost in my case is around 13k
-- Step 2and now let's test by forcing a specific join alg:
-- Nested loops:
select /*+ USE_NL(students fg) */ scholarship from fg join students on fg.lnamea=students.lname  where fg.lnamea like 'A%';
-- cost in my case is around 15k
-- Nested loops:
select /*+ use_hash */ scholarship from fg join students on fg.lnamea=students.lname  where fg.lnamea like 'A%';
-- like the initial case - which was executed with hash joins: 13k
-- Step 4:
-- Let's now create an index:
create index idx_join_fg on fg(lnamea)
/
select /*+ USE_NL(students fg) */ scholarship from fg join students on fg.lnamea=students.lname  where fg.lnamea like 'A%';
-- cost in my case is around 1k
-- Nested loops:
select /*+ use_hash */ scholarship from fg join students on fg.lnamea=students.lname and fg.fnamea=students.fname where fg.lnamea like 'A%';
-- cost: 0.6k
-- if you really want to use nested loops you and you have very large tables, you have to index the attributes 
-- from the second table (to make faster access in the innter loop)
-- so, for nested loops this is the actual way to go:
create index idx_join_students on students(lname);
-- now let's try that again (the nested loops)
select /*+ USE_NL(students fg) */ scholarship from fg join students on fg.lnamea=students.lname  where fg.lnamea like 'A%';
-- in my case it uses both indexes but he still gets a cost of 1k (probably just because the table students is so small)
-- for nested loops you should index the fields that are searched in the inner table (most important) and the
-- ones that are used for filtering in the first table (less important)
-- for hash joins, since they will create an inner hash and you cannot index that, you should only index what is after the where clause...
drop index idx_join_students
/
-- Step 5 - the index in where clause is used by both hash and merge joins:
select /*+ use_hash */ scholarship from fg join students on fg.lnamea=students.lname  where fg.lnamea like 'A%';
select /*+ use_merge(fg,students) parallel(fg, 4) parallel(students, 4) */ scholarship from fg join students on fg.lnamea=students.lname  where fg.lnamea like 'A%';
-- without this, it will give you huge costs.
drop index idx_join_fg
/



--------- K: Clustering data
-- index filters used intentionally:
-- Step 1: see the execution plan for:
SELECT lnameA, fnameA, dobA FROM fg WHERE valueA = 9 and UPPER(lnameA) LIKE '%ACK%'; 
-- index at least valueA (because you cannot index for lnameA or upper(lnameA) ... since the 
-- value in LIKE has % both at begin and end.
-- Step 2:
create index idx_valueA on fg(valueA);
-- now the execution plan should use the index:
SELECT lnameA, fnameA, dobA FROM fg WHERE valueA = 9 and UPPER(lnameA) LIKE '%ACK%'; 
-- can we lower the cost ?
-- yea: by adding the upper(lnamea) he won;t have to filter data from the table;
-- he will do it directly from the index:
-- step 3:
drop index idx_valueA
/
create index idx_valuea_upplnamea on fg(valueA, UPPER(lnameA))
/
-- check it out again:
SELECT lnameA, fnameA, dobA FROM fg WHERE valueA = 9 and UPPER(lnameA) LIKE '%ACK%'; 
-- now the cost is much much lower just because he could filter data directly from index.
drop index idx_valuea_upplnamea
/

-- index only scan:
-- Step 4: create the following index:
create index idx_only_scan on fg(lnameA, fnameA, dobA);
-- and now here is a select that will only use the index:
select fnameA, lnameA, dobA from fg where lnameA = 'Jackson';
-- Step 5:
--check out the difference in execution plans for:
select fnameA, lnameA, dobA from fg where lnameA = 'Jackson' and dobA=sysdate;
--and 
select fnameA, lnameA, dobA from fg where lnameA = 'Jackson' and fnamea='Michael';
-- why?
-- The second one can use access directly from index (because lnamea and fnamea are 
-- the first two columns indexed. The first one (the one with lname and dobA can 
-- access based on the lnamea and only filter from the index those rows having
-- a certain dobA. However, because the information is in the index, there is no
-- table access.
drop index idx_only_scan;


--------- L: IOT
--Step 1:
-- create a IOT (it is actually the table students but organized as an index (IOT)
CREATE TABLE stud (
  id INT NOT NULL PRIMARY KEY,
  registration_number VARCHAR2(6) NOT NULL,
  lname VARCHAR2(15) NOT NULL,
  fname VARCHAR2(30) NOT NULL,
  year NUMBER(1),
  groupno CHAR(2),
  scholarship NUMBER(6,2),
  dob DATE,
  email VARCHAR2(40),
  created_at DATE,
  updated_at DATE
) ORGANIZATION INDEX;
/
-- step 2:
-- insert now all the lines in the table students:
insert into STUD (id, registration_number, lname, fname, year, groupno, scholarship, dob, email, created_at, updated_at) select * from students;
/
-- step 3:
-- any select will be an access into a table. See the execution plan for the following queries:
select * from stud;
-- probably, the cost in the original table is smaller ? try the execution plan for:
select * from students;
-- step 5:
-- however, this runs faster on the IOT:
select id, registration_number from stud where id between 10 and 100;
--compared to the original table(even though there is an index on the primary key - the id). can you say why ?
select id, registration_number from students where id between 10 and 100; 
--AnsewerL because in the IOT there is no need for table access by index row ID.
-- step 6:
-- if you want to find some information that is not indexed first in the iot:
select id from stud where scholarship>1000;
select id from students where scholarship>1000; -- in the students is faster ?
--Try to create a secondary index and see how it is accessed.
drop table stud;





-------- M: order by
-- Step 1: see how this is executed:
-- this should have a huge cost (because it has to sort oud all data):
select lnameA, fnameA, dobA from fg order by dobA;
-- you can observe that the highest cost is added by the sorting algorithm:
-- now let's create an index that can access based on dobA:
create index idx_dobA on fg(dobA, lnameA, fnameA);
-- now if you do the same operation, you will see that there is no sorting algorithm:
select lnameA, fnameA, dobA from fg order by dobA;
-- not having to sort all the data, the cost is smaller now. (although is still big because 5 millions rows are returned).
drop index idx_dobA;

-- step 2,3,4,etc: we are interested in using 2 fields and an oreder by (this way you will see that the index is not all powerfull):
create index idx_vala_doba on fg(valuea,doba);
-- now let's do the following querry:
select valuea, doba from fg where valuea=9 order by doba;
-- what heppens if the search interval is larger:
select valuea, doba from fg where valuea between 8 and 9 order by doba;
-- it won;t work (needs sorting) because you have shuffled doba in the ranges of the two values 8 and 9.
-- however, this will be ok (no sort again):
select valuea, doba from fg where valuea between 8 and 9 order by valuea, doba;
-- because the data are in the same order as in the index.
-- also, we can scan the index backwards. so the following will also work on index and won;t need sorting:
select valuea, doba from fg where valuea between 8 and 9 order by valuea desc, doba desc;
-- however, this will need (again) sorting:
select valuea, doba from fg where valuea between 8 and 9 order by valuea desc, doba asc;
-- this is because the order needed is not the same as in the index.
drop index idx_vala_doba;
-- let's recreate the index for the las querry to avoid sorting: you can do any of the following
create index idx_vala_doba on fg(valuea desc ,doba asc);
create index idx_vala_doba on fg(valuea asc, doba desc);
-- this will now work withut sorting:
select valuea, doba from fg where valuea between 8 and 9 order by valuea desc, doba asc;
drop index idx_vala_doba;





-------N: Group by
--Step 1: create the index on the grouping cryteria:
create index idx_grades on grades(grading_date, id_student);
select count(*) from grades where grading_date between to_date('01-01-2015','DD-MM-YYY') and to_date('01-06-2015','DD-MM-YYY') group by id_student;
-- actually, the upper scenario uses hash group by.... maybe is there a way to force sort group by ?
select /*+ NO_USE_HASH_AGGREGATION */ count(*) from grades where grading_date between to_date('01-01-2015','DD-MM-YYY') and to_date('01-06-2015','DD-MM-YYY') group by id_student;
drop index idx_grades




-------O: Fetch first...
SELECT * FROM (SELECT doba FROM fg where valuea=9 ORDER BY doba) WHERE rownum <= 10;
-- and now create the index:
create index idx_doba on fg(valuea,doba);
-- this index will allow the execution to be pipelined and to only get the first 10 rows:
-- try this again:
SELECT * FROM (SELECT doba FROM fg where valuea=9 ORDER BY doba) WHERE rownum <= 10;
--after getting the first page, that contains 10 rows, you need the rows 11 to 20:
SELECT * FROM (SELECT tmp.*, rownum rn FROM (SELECT * FROM fg WHERE valuea=9 ORDER BY doba DESC ) tmp WHERE rownum <= 20) WHERE rn > 10;
-- this will get the first 20 rows and filter out the first 10.
-- the dissaadvantage when using offset method is that on a nth page you have to get n*10 records and discard (n-1)*10.
drop index idx_doba;






-------P: Fetch 11-20 using window:
create index idx_doba on fg(doba,id);
SELECT * FROM ( 
     SELECT fg.* , ROW_NUMBER() OVER   
       (ORDER BY doba DESC ,  
                       id DESC) rn 
     FROM fg) tmp 
 WHERE rn between 11 and 20 
 ORDER BY doba DESC, id DESC;
-- even though he estimates to execute the window with a cost of 65k (in my case), the execution time is 0 seconds
drop index idx_doba;




-- some usefull commands are commented below:
--commit;
--select index_name from user_indexes;
--desc fg;