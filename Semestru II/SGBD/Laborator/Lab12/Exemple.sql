/*1. Pentru fiecare student in parte construiti-i carnetul de note prin
intermediul unui script PL/SQL. Tabelul creat va avea ca si nume s||id-ul studentului (pentru unicitate).
Campurile tabelului sunt: Disciplina, Profesor, Nota si Data Examinarii. Daca tabela exista deja, creati un mesaj de exceptie.
Creati apoi un script (bloc anonim) care sa stearga tabelele nou create.*/

CREATE OR REPLACE PROCEDURE carnet_de_note (IN_id_student IN studenti.id%TYPE)
IS
  v_CursorID NUMBER;--variabila careia i se atribuie valoarea de catre open cursor
  v_CreateTableString VARCHAR2(1024);--SQL stocat ca sir pentru inserarea de valori
  v_NUMRows INTEGER;--numar de randuri prelucrate
  
  CURSOR c1
  IS
    SELECT s.nume as nume, s.prenume as prenume, valoare, data_notare, titlu_curs, grad_didactic, p.nume as nume_prof, p.prenume as prenume_prof
    FROM studenti s join note n on s.id = n.id_student JOIN cursuri c ON n.id_curs = c.id JOIN didactic d ON c.id = d.id_curs JOIN profesori p ON d.id_profesor = p.id
    WHERE n.id_student = IN_id_student;
BEGIN 

  v_CursorID := DBMS_SQL.OPEN_CURSOR;--se obtine identificatorul cursorului
  
  v_CreateTableString := 'CREATE TABLE s' || IN_id_student || ' (
    Nume VARCHAR2(64) NOT NULL,
    Prenume VARCHAR2(64) NOT NULL, 
    Disciplina VARCHAR2(64) NOT NULL,
    Profesor VARCHAR2(128) NOT NULL,
    Nota NUMBER(2) NOT NULL,
    Data_Examinarii DATE NOT NULL
    )';
  
  DBMS_SQL.PARSE(v_CursorID, v_CreateTableString, DBMS_SQL.NATIVE);--depistarea erorilor sintactice(se analizeaza instructiunea SQL)
  
  v_NUMRows := DBMS_SQL.EXECUTE(v_CursorID);--executarea instructiunii SQL
  
  DBMS_SQL.CLOSE_CURSOR(v_CursorID);--inchiderea cursorului
  
  FOR c1_record IN c1 LOOP
    v_CursorID := DBMS_SQL.OPEN_CURSOR;
    
    DBMS_SQL.PARSE(v_CursorID, 'INSERT INTO s' || IN_id_student || ' (Nume, Prenume, Disciplina, Profesor, Nota, Data_Examinarii) 
		VALUES (:Nume, :Prenume, :Disciplina, :Profesor, :Nota, :Data_Examinarii)', DBMS_SQL.NATIVE);
    
    DBMS_SQL.BIND_VARIABLE(v_CursorID, ':Nume', c1_record.nume);
    DBMS_SQL.BIND_VARIABLE(v_CursorID, ':Prenume', c1_record.prenume);
    DBMS_SQL.BIND_VARIABLE(v_CursorID, ':Disciplina', c1_record.titlu_curs);
    DBMS_SQL.BIND_VARIABLE(v_CursorID, ':Profesor', c1_record.grad_didactic || ' ' || TRIM(c1_record.nume_prof) || ' ' || TRIM(c1_record.prenume_prof));
    DBMS_SQL.BIND_VARIABLE(v_CursorID, ':Nota', c1_record.valoare);
    DBMS_SQL.BIND_VARIABLE(v_CursorID, ':Data_Examinarii', c1_record.data_notare);
    
    v_NUMRows := DBMS_SQL.EXECUTE(v_CursorID);--executarea instructiunii SQL
    
    DBMS_SQL.CLOSE_CURSOR(v_CursorID);
  END LOOP;
  
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE != -955
        THEN
          RAISE;
        ELSE
          DBMS_OUTPUT.PUT_LINE('Error: Table Already Exists!');
      END IF;
    
    DBMS_SQL.CLOSE_CURSOR(v_CursorID);
    COMMIT;
END carnet_de_note;
/
--apelul procedurii
/
DECLARE
  CURSOR c1 IS
  SELECT id
  FROM studenti;
BEGIN
  FOR c1_record IN c1 LOOP
    carnet_de_note(c1_record.id);
  END LOOP;
END;
/
select * from s1;
/
--bloc anonim de stergere a tabelelor create 
begin
  for i in (select table_name from user_tables where table_name like 'S%' and table_name <>'STUDENTI') loop
    execute immediate'drop table '|| i.table_name ||' cascade constraints';
  end loop;
end;


/*2. Apelati inca o data procedura de la punctul 1. Construiti o functie sau procedura care sa preia ca parametru id-ul studentului si
sa afiseze datele despre acesta din tabelul creat la punctul anterior.*/
CREATE OR REPLACE PROCEDURE afiseaza_carnet (IN_id_student IN studenti.id%TYPE)
IS
  v_CursorID NUMBER;--variabila careia i se atribuie valoarea de catre open cursor
  v_SelectRecords VARCHAR2(128);--SQL stocat ca sir pentru selectarea de valori
  v_NUMRows INTEGER;--numar de randuri prelucrate
  
  v_Nume VARCHAR2(100);
  v_Prenume VARCHAR2(100);
  v_Disciplina VARCHAR2(64);
  v_Profesor VARCHAR2(128);
  v_Nota NUMBER(2);
  v_Data_Examinarii DATE;
  
  v_indx INTEGER := 1;
BEGIN
  v_CursorID := DBMS_SQL.OPEN_CURSOR;--se deschide cursorul
  
  v_SelectRecords := 'SELECT * FROM S' || IN_id_student;
  
  DBMS_SQL.PARSE(v_CursorID,v_SelectRecords,DBMS_SQL.NATIVE);--depistarea erorilor sintactice(se analizeaza instructiunea SQL)
  
  DBMS_SQL.DEFINE_COLUMN(v_CursorID, 1, v_Nume, 100);
  DBMS_SQL.DEFINE_COLUMN(v_CursorID, 2, v_Prenume, 100);
  DBMS_SQL.DEFINE_COLUMN(v_CursorID, 3, v_Disciplina, 64);
  DBMS_SQL.DEFINE_COLUMN(v_CursorID, 4, v_Profesor, 128);
  DBMS_SQL.DEFINE_COLUMN(v_CursorID, 5, v_Nota);
  DBMS_SQL.DEFINE_COLUMN(v_CursorID, 6, v_Data_Examinarii);
  
  v_NUMRows := DBMS_SQL.EXECUTE(v_CursorID);--executarea instructiunii SQL
  
  DBMS_OUTPUT.PUT_LINE('    Carnet De Note: (' || IN_id_student || ')');
  DBMS_OUTPUT.PUT_LINE('#. Nume: Prenume: Disciplina : Profesor : Nota : Data Examinarii');
  
  LOOP
    IF DBMS_SQL.FETCH_ROWS(v_CursorID) = 0
      THEN
        EXIT;
    END IF;
    
    DBMS_SQL.COLUMN_VALUE(v_CursorID, 1, v_Nume);
    DBMS_SQL.COLUMN_VALUE(v_CursorID, 2, v_Prenume);
    DBMS_SQL.COLUMN_VALUE(v_CursorID, 3, v_Disciplina);
    DBMS_SQL.COLUMN_VALUE(v_CursorID, 4, v_Profesor);
    DBMS_SQL.COLUMN_VALUE(v_CursorID, 5, v_Nota);
    DBMS_SQL.COLUMN_VALUE(v_CursorID, 6, v_Data_Examinarii);
    
    DBMS_OUTPUT.PUT_LINE(v_indx || '. ' || v_Nume || ' : ' || v_Prenume || ' : ' || v_Disciplina || ' : ' || v_Profesor || ' : ' || v_Nota || ' : ' ||v_Data_Examinarii);
    
    v_indx := v_indx + 1;
  END LOOP;
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
    DBMS_SQL.CLOSE_CURSOR(v_CursorID);
END afiseaza_carnet;
/
begin
	afiseaza_carnet(1);
end;	


--3.Creati, folosind native sql, o noua tabela. 
CREATE OR REPLACE PROCEDURE  create_table (IN_table_name       VARCHAR2,
                                           IN_table_columns    VARCHAR2)
IS 
  l_sql VARCHAR2(400);--sirul SQL (de exemplu aici e pentru crearea tabelelor)
BEGIN
  l_sql := 'CREATE TABLE '|| IN_table_name || IN_table_columns;
  DBMS_OUTPUT.PUT_LINE('Sql is '||l_sql);
  EXECUTE IMMEDIATE l_sql; 
END create_table;
/
EXEC create_table('ANGAJATI','(marca NUMBER,nume VARCHAR2(100),prenume VARCHAR2(100))');
/
desc ANGAJATI;


--4.Extragere de informatii pe baza unui single-select
--exemplul 1 - functie care returneaza nr de valori 
CREATE OR REPLACE FUNCTION get_count(IN_table VARCHAR2)  
RETURN NUMBER
IS
  l_count NUMBER;
  l_query VARCHAR2(200);
BEGIN 
  l_query := 'SELECT COUNT(*) FROM ' || IN_table; 
    EXECUTE IMMEDIATE l_query INTO l_count; 
  RETURN l_count;
END get_count;
/
DECLARE
  l_cnt NUMBER;
  l_cnt1 NUMBER;
BEGIN
  l_cnt := get_count('STUDENTI');
  l_cnt1 := get_count('NOTE');
    DBMS_OUTPUT.PUT_LINE('Count is '||l_cnt); 
    DBMS_OUTPUT.PUT_LINE('Count is '||l_cnt1); 
END; 


--5.Clauze DML
--inserare de inregistrari
--nr de bind values = nr de bind variables
create or replace procedure insert_record(p_table_name varchar2, p_col1_name varchar2, p_col1_value number, p_col2_name varchar2, p_col2_value varchar2, p_col3_name varchar2, p_col3_value varchar2)
is
begin
  execute immediate 'insert into '||p_table_name ||'('||p_col1_name||','||p_col2_name||','||p_col3_name||') '||'values(:col1_value,:col2_value,:col3_value)' using p_col1_value, p_col2_value, p_col3_value;
  commit;
end insert_record;
/
declare 
  l_null varchar2(1);
begin
  insert_record('angajati', 'marca', 1, 'nume', 'Ionescu', 'prenume', 'Gigel');
end;
/
select * from angajati;

--stergere
create or replace procedure delete_from_table(p_table_name varchar2)
is
begin
  execute immediate 'delete from '||p_table_name;
  commit;
end delete_from_table; 
/
exec delete_from_table('angajati');
