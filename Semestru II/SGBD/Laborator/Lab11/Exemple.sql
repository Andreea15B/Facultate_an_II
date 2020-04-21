--Exemplu din documentatie
--din contul de sys: GRANT EXECUTE ON UTL_FILE TO STUDENT;
--din contul de sys: GRANT CREATE ANY DIRECTORY TO STUDENT;
--din contul student: CREATE OR REPLACE DIRECTORY MYDIR as 'C:\Baze de date - cursuri\Practica SGBD\2018-2019\lab7';
create or replace procedure p_create_document 
is
  v_fisier UTL_FILE.FILE_TYPE;
begin
  v_fisier:=UTL_FILE.FOPEN('MYDIR','myfile.txt','W');
  UTL_FILE.PUTF(v_fisier,'abcdefg');
  UTL_FILE.FCLOSE(v_fisier);
end;
/
exec p_create_document;


/*1. Creati o procedura care sa exporte toate datele dintr-o baza de date: la apelul acestuia se va construi un fisier, preferabil
cu extensia SQL in care vor fi trecute toate datele, functiile, procedurile, viewurile si triggerele pentru care un utilizator este owner.*/ 
CREATE OR REPLACE DIRECTORY MYDIR AS 'C:\Baze de date - cursuri\Practica SGBD\2018-2019\lab7';
/
create or replace procedure export_data
is
  fisier UTL_FILE.FILE_TYPE;
  p_obj CLOB;
  p_query VARCHAR2(300);
begin
  fisier := UTL_FILE.FOPEN ('MYDIR', 'Export.sql', 'W');
  
  FOR i IN (SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE') LOOP
    SELECT DBMS_METADATA.GET_DDL(i.OBJECT_TYPE,i.OBJECT_NAME) 
    INTO p_obj 
    FROM dual;
    --dbms_output.put_line(myObject);
    UTL_FILE.PUT_LINE(fisier,p_obj);
  END LOOP;
  
  FOR i IN (SELECT DBMS_METADATA.GET_DDL('INDEX', INDEX_NAME) as METADATA_INDEX FROM USER_INDEXES) LOOP
    UTL_FILE.PUT_LINE(fisier,i.METADATA_INDEX);
    --dbms_output.put_line(i.METADATA_INDEX);
  END LOOP;
  
  FOR i IN (SELECT text FROM user_views) LOOP
    UTL_FILE.PUT_LINE(fisier,i.TEXT);
    --dbms_output.put_line(i.TEXT);
  END LOOP;
  
  FOR i IN (SELECT text FROM user_source) LOOP
    UTL_FILE.PUT_LINE(fisier,i.TEXT);
    --dbms_output.put_line(i.TEXT);
  END LOOP;
 
  FOR i IN (SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE') LOOP
    p_query:='select /*insert*/ * from '||i.OBJECT_NAME;
    DBMS_OUTPUT.PUT_LINE(p_query);
  END LOOP;
 
  UTL_FILE.FCLOSE (fisier);
END;
/
exec export_data;

/*2. Creati o procedura care sa stearga tabelele din schema utilizatorului cu care sunteti logat.*/
create or replace procedure delete_tables
is
  cursor c1 is 
  select object_type,object_name 
  from user_objects 
  where object_type = 'TABLE';
begin
  for c1_record in c1 loop
    execute immediate ('drop '||c1_record.object_type||' ' ||c1_record.object_name||' cascade constraints');
  end loop;
end;
/
exec delete_tables;

--Urmatoarele exemple sunt cateva interogari simple care ilustreaza lucrul efectiv cu dictionarul de date pentru schema unui utilizator

/*3.Sa se afiseze toate tabele din baza de date care incep cu litera S, impreuna cu numele tablespaceului unde acestea sunt
continute si cu nr de inregistrari continute. Sa se afiseze si daca tabela are si un back-up de la ultima modificare.*/
select Table_Name,TABLESPACE_NAME,NUM_ROWS,dependencies
from USER_TABLES
where Table_Name like 'S%';
--all_tables are tabele suplimentare, nu doar cele ale utilizatorului
select Table_Name,TABLESPACE_NAME,NUM_ROWS,Backed_Up
from ALL_TABLES
where Table_Name like 'S%';

/*4.Pentru tabela DIDACTIC, vizualizati constringerile create si coloanele asociate folosind tabelele USER_CONSTRAINTS 
si USER_CONS_COLUMNS, folosind o singura interogare!! */
select uc.owner,uc.constraint_name,constraint_type,column_name,position
from user_constraints uc inner join user_cons_columns ucc on uc.table_name=ucc.table_name and uc.constraint_name=ucc.constraint_name
where uc.table_name='DIDACTIC'; 

/*5.Afisati toti indecsii din tabela NOTE, impreuna cu coloanele indexate si verificati care indecsi sunt unici si care nu.*/
select ui.Index_Name, Uniqueness, Column_Name, Column_Position
from USER_INDEXES ui join USER_IND_COLUMNS uic on ui.index_name=uic.index_name
where Table_Owner = 'STUDENT' and ui.Table_Name = 'NOTE';

/*6.Sa se afiseze numele campurilor, tipul si dimensiunea pentru tabela 'PRIETENI'.*/
select Column_Name, Data_Type, Data_Length
from USER_TAB_COLUMNS
where Table_Name = 'PRIETENI';

/*7.Afisati pentru toate view-urile din baza de date lungimea acestora, impreuna cu textul aferent.*/
select View_Name, text, Text_Length
from USER_VIEWS;

/*8.Adaugati un comentariu la campul NUME din tabela STUDENTI. Afisati apoi acel comentariu. Eliminati apoi comentariul.*/
comment on column studenti.nume is 'Numele de familie al studentului';
/
select Comments
from USER_COL_COMMENTS
where Table_Name = 'STUDENTI' and Column_Name = 'NUME';
/
comment on column studenti.nume is '';

