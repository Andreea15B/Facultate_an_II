--tabele ajutatoare pentru procedura de insert
drop table inume;
drop table iprenume;
drop table nume;
drop table prenume;
/
create table nume(n varchar2(100));
create table prenume(p varchar2(100));
create table inume(nr number, nume varchar2(200));
create table iprenume(nr number, prenume varchar2(200));
/
INSERT INTO prenume VALUES ('Mihai');
INSERT INTO prenume VALUES ('Gigel');
INSERT INTO prenume VALUES ('Marius');
INSERT INTO prenume VALUES ('Adina');
INSERT INTO prenume VALUES ('Ioana');
/
INSERT INTO nume VALUES ('Simionescu');
INSERT INTO nume VALUES ('Negrutu');
INSERT INTO nume VALUES ('Popescu');
INSERT INTO nume VALUES ('Popa');
INSERT INTO nume VALUES ('Matei');
/
INSERT INTO inume SELECT ROWNUM, n FROM nume;
INSERT INTO iprenume SELECT ROWNUM, p FROM prenume;

/*1.Scrieti o functie care sa verifice daca un student, pe baza unui id, exista in baza de date.*/
create or replace function f_exista_student(IN_id_student in studenti.id%type) return boolean
  is
    e_std boolean;
    p_number number;--0 daca studentul nu exista, 1 daca exista
  begin
    select count(*)
    into p_number
    from studenti
    where id=IN_id_student;
    if p_number=0 then
      dbms_output.put_line('Studentul cu id-ul '||IN_id_student||' nu exista in baza de date !');
      e_std:=false;
      --return false;
    else
      e_std:=true;
      --return true;
    end if;
    return e_std;
  end f_exista_student; 

/*2. Construiti o procedura care sa returneze in doi parametri de iesire
valorile mediilor din anii trecuti pentru un student al carui ID este dat intr-un
parametru de tip IN. Exemplificati utilizarea ei intr-un bloc anonim.
Folositi de asemenea si functia care verifica daca studentul, dat prin ID, exista in baza de date !*/
CREATE OR REPLACE PROCEDURE p_medii_var(IN_id_student IN studenti.id%type, OUT_medie1 OUT float, OUT_medie2 OUT float)
AS
  p_an number(1);
  p_exist boolean;
BEGIN
  p_exist := f_exista_student(IN_id_student);
  if p_exist = true then
    select an 
    into p_an 
    from studenti
    where id=IN_id_student;
    if (p_an=1) then 
      DBMS_OUTPUT.PUT_LINE('Studentul cu id-ul ' ||IN_id_student|| ' este in anul 1 si nu are medie !');
    elsif(p_an=2) then
      select trunc(avg(valoare),2)
      into OUT_medie1
      from note n join cursuri c on c.id=n.id_curs
      where id_student=IN_id_student and an=1;
      DBMS_OUTPUT.PUT_LINE('Media din anul I este : ' || OUT_medie1);
    elsif(p_an=3) then
      select trunc(avg(valoare),2)
      into OUT_medie1
      from note n join cursuri c on c.id=n.id_curs
      where id_student=IN_id_student and an=1;
      DBMS_OUTPUT.PUT_LINE('Media din anul I este : ' || OUT_medie1);
      select trunc(avg(valoare),2)
      into OUT_medie2
      from note n join cursuri c on c.id=n.id_curs
      where id_student=IN_id_student and an=2;
      DBMS_OUTPUT.PUT_LINE('Media din anul II este : ' || OUT_medie2);
    else null;  
    end if;
  end if;
end;
/
--apelul
declare
  p_nr_matricol NUMBER:=7777;
  p_medie1 NUMBER(4,2);
  p_medie2 NUMBER(4,2);
BEGIN
  p_medii_var(p_nr_matricol,p_medie1,p_medie2);
END;

/*3.Scrieti o procedura ce returneaza varsta unui student (in ani, luni si zile).
Studentul se stabileste random, astfel incat nu este nevoie de utilizarea functiei care verifica existenta lui !*/
create or replace procedure p_afiseaza_varsta
  is
    p_numar_studenti number(5);
    p_student_random number(5);
    p_rezultat VARCHAR(1000);
  begin
    select count(*) 
    into p_numar_studenti
    from studenti;
    p_student_random := dbms_random.value(1,p_numar_studenti);
    select id||' '||nume||' '||prenume||' '||varsta
    into p_rezultat
    from
      (select id,nume,prenume,trunc(months_between(sysdate,data_nastere)/12)||' ani '||
      floor(to_number(months_between(sysdate,data_nastere)-(trunc(months_between(sysdate,data_nastere)/12))*12))||' luni '||
      floor(to_number(sysdate-add_months(data_nastere,trunc(months_between(sysdate,data_nastere)))))||' zile. ' as varsta, rownum as rand
      from studenti)
    where rand = p_student_random;
    dbms_output.put_line(p_rezultat);
  end p_afiseaza_varsta; 
/
--apelul
exec p_afiseaza_varsta;

/*4.Scrieti o procedura care sa adauge un student in baza de date (cu generare de ID, matricol si simulare de note la materiile din anii precedenti - 
de exemplu daca este in anul 3 va avea note la materiile din anii 1 si 2, daca este in anul 2 doar la materiile din anul 1, daca este in anul 1 nu va avea note.)*/
create or replace procedure p_add_student_studenti
  is
    p_count number :=0;
    p_nr_nume number :=100;
    p_nr_prenume number :=100;
    p_temp number :=0;
    p_nume varchar2(15);
    p_prenume varchar2(15);
    p_an_random number;
    p_grupa_random varchar2(2);
    p_id_curs cursuri.id%type;
    p_matr studenti.nr_matricol%type;
    p_max_id_student studenti.id%type;
  begin
    p_matr:= floor(dbms_random.value(100,999)) || chr(floor(dbms_random.value(65,91))) || 
      chr(floor(dbms_random.value(65,91))) || chr(floor(dbms_random.value(0,9)));
    --cati studenti sunt dupa nume
    select count(*) 
    into p_nr_nume 
    from inume;
   --cati studenti sunt dupa prenume
    select count(*) 
    into p_nr_prenume
    from iprenume;         
    loop
      p_temp := trunc(dbms_random.value(1,p_nr_nume));
      select nume 
      into p_nume 
      from inume 
      where nr = p_temp; 
         
      p_temp := trunc(dbms_random.value(1,p_nr_prenume));      
      select prenume 
      into p_prenume 
      from iprenume 
      where nr = p_temp;
                  
      select count(*) 
      into p_temp 
      from studenti
      where nume=p_nume and prenume=p_prenume;
    
      if(p_temp = 0) then
        select max(id) 
        into p_temp 
        from studenti;
        p_temp := p_temp + 1;
        p_an_random := trunc(dbms_random.value(1,4));
       
        insert into studenti(id, nr_matricol, nume, prenume, an, created_at, updated_at) values (p_temp, p_matr, p_nume, p_prenume, p_an_random, sysdate, sysdate);
          p_count := p_count + 1;
        exit when p_count = 1;
         
      end if;  
    end loop;
  end p_add_student_studenti;
/
--apelul
exec p_add_student_studenti;
/
--verificare ca se face insertul corect
select * from studenti where id = (select max(id) from studenti);

/*5.Creati un raport care sa afiseze toate notele pt un student dat ca parametru*/
--procedura de creare a unui raport
--dorim sa facem un raport cu detaliile studentului dat ca parametru  
-- pentru ca procedura aceasta sa functioneze trebuie creat obiectul DIR_DETALII_STUDENTI astfel:
-- create or replace directory DIR_DETALII_STUDENTI as 'c:\Baze de date - cursuri\Practica SGBD\2018-2019\lab3'; (din contul de sys)
-- de asemenea, numai contul de sys are voie sa foloseasca UTL_FILE
-- procedura ajutatoare
create or replace procedure p_showFile(IN_f_file in studenti.nume%TYPE, IN_id_student in studenti.id%type)
  is
 		p_file UTL_FILE.FILE_TYPE;
    
    cursor c1 is 
    select s.id, nr_matricol, nume, prenume, s.an as an, grupa, nvl(bursa,0) as bursa, titlu_curs, c.an as an_curs, valoare
    from studenti s join note n on s.id=n.id_student join cursuri c on c.id=n.id_curs 
    where s.id=IN_id_student;
    
 	begin
 		p_file:= UTL_FILE.FOPEN('DIR_DETALII_STUDENTI', IN_f_file, 'w');
    UTL_FILE.PUT_LINE(p_file, 'REPORT: GENERATED ON ' || SYSDATE);
    UTL_FILE.NEW_LINE (p_file);
 		for c1_record in c1 loop
      UTL_FILE.PUT_LINE(p_file, c1_record.id || ' '|| c1_record.nr_matricol || ' ' || c1_record.nume || ' ' || c1_record.prenume || ' ' || c1_record.an || ' ' || c1_record.grupa || ' ' || 
      c1_record.bursa || ' ' || c1_record.titlu_curs|| ' '|| c1_record.an_curs|| ' ' ||c1_record.valoare,TRUE);
 		end loop;
    UTL_FILE.PUT_LINE(p_file,'*** END OF REPORT ***'); 
 		UTL_FILE.FCLOSE(p_file);
	exception
    WHEN UTL_FILE.WRITE_ERROR THEN
      dbms_output.put_line('Operating system error occurred during the write operation.');
   	WHEN UTL_FILE.INVALID_PATH THEN
    	dbms_output.put_line('Invalid path.');
   	WHEN OTHERS then
      dbms_output.put_line('Other error');
 	end p_showFile;

--procedura pentru modul de afisare, raport sau pe ecran
create or replace procedure p_showStudenti(IN_way in studenti.nume%TYPE, IN_id_student studenti.id%type)
  is
    f studenti.nume%type:='raport.txt';
    cursor c1 is 
    select s.id, nr_matricol,nume,prenume,s.an as an,grupa,nvl(bursa,0) as bursa,titlu_curs,c.an as an_curs,valoare
    from studenti s join note n on s.id=n.id_student join cursuri c on c.id=n.id_curs 
    where s.id=IN_id_student;
 	begin
    if IN_way='ecran' then
      for c1_record in c1 loop
        dbms_output.put_line(c1_record.id || ' ' ||c1_record.nr_matricol || ' ' || c1_record.nume || ' ' || c1_record.prenume || ' ' || c1_record.an || ' ' || c1_record.grupa || ' ' || 
          c1_record.bursa || ' ' || c1_record.titlu_curs|| ' '|| c1_record.an_curs|| ' ' ||c1_record.valoare);
      end loop;
 		else 
      p_showFile(f,IN_id_student);
 		end if;
  end p_showStudenti;  
/
--apelul
exec p_showStudenti('ecran',1);
exec p_showStudenti('fisier',1); 


--tabela de ajutor pentru una din probleme 
drop table zodiac;
/
create table zodiac(
  id_zodie number(10) primary key,
  nume_zodie varchar2(30),
  data_inceput varchar2(10),
  data_sfarsit varchar2(10)); 
/
insert into zodiac values(1,'berbec', '21-03', '20-04');
insert into zodiac values(2,'taur', '21-04', '21-04');
insert into zodiac values(3,'gemeni', '22-05', '21-06');
insert into zodiac values(4,'rac', '22-06', '22-07');
insert into zodiac values(5,'leu', '23-07', '22-08');
insert into zodiac values(6,'fecioara', '23-08', '21-09');
insert into zodiac values(7,'balanta', '22-09', '22-10');
insert into zodiac values(8,'scorpion', '23-10', '21-11');
insert into zodiac values(9,'sagetator', '22-11', '20-12');
insert into zodiac values(10,'capricorn', '21-12', '19-01');
insert into zodiac values(11,'varsator', '20-01', '18-02');
insert into zodiac values(12,'pesti', '19-02', '20-03');






