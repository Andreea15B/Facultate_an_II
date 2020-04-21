/*1. Construiti o procedura in care sa afisati distributia pe zodii a studentilor din baza de date. Inserati apoi aceste informatii intr-o noua tabela numita
zodii_distributie. Rescrierea unei probleme de la lab trecut folosind colectie de tip RECORD, precum si vectori*/

--a.rescriere cu vectori
--redefinim type-urile in caz ca nu mai exista si de asemenea cream noua tabela zodii_distributii
create or replace type num_arr as table of number;
/
create or replace type vc_arr as table of varchar2;
/
drop table zodii_distributii;
/
create table zodii_distributii(zodie varchar2(20), numar_studenti number);
/
create or replace procedure p_zodiac 
is 
  p_nume_zodie_arr    vc_arr;
  p_distributie_arr   num_arr;
begin
  delete from zodii_distributii;--am pus delete ca la fiecare rulare sa insereze doar o data !
  select nume_zodie, distributie
  bulk collect into p_nume_zodie_arr, p_distributie_arr
  from
  (select nume_zodie as nume_zodie, count(*) as distributie
  from zodiac z left join studenti s on to_date(to_char(s.data_nastere,'DD-MM'),'DD-MM') between to_date(z.data_inceput, 'DD-MM') and to_date(z.data_sfarsit, 'DD-MM')
  group by nume_zodie);

  if p_distributie_arr.count<>0 then 
    forall i in p_distributie_arr.first .. p_distributie_arr.last
      insert into zodii_distributii(zodie, numar_studenti) values (p_nume_zodie_arr(i), p_distributie_arr(i));
  end if;
end;
/
exec p_zodiac;
/
select * from zodii_distributii;

--b.rescriere cu tabela de tip RECORD
create or replace procedure p_zodiac 
is 
  type zodii_table_arr is record (nume_zodie_arr varchar2(20), distributie_arr number);
  type items_zodii_table_arr is table of zodii_table_arr;
  l_items_zodii_table_arr items_zodii_table_arr:=items_zodii_table_arr();
begin
  delete from zodii_distributii;
  select nume_zodie_arr, distributie_arr
  bulk collect into l_items_zodii_table_arr
  from
  (select nume_zodie as nume_zodie_arr, count(*) as distributie_arr
  from zodiac z left join studenti s on to_date(to_char(s.data_nastere,'DD-MM'),'DD-MM') between to_date(z.data_inceput, 'DD-MM') and to_date(z.data_sfarsit, 'DD-MM')
  group by nume_zodie);

  if l_items_zodii_table_arr.count <> 0 then
    forall i in l_items_zodii_table_arr.first .. l_items_zodii_table_arr.last
      insert into zodii_distributii(zodie, numar_studenti) values (l_items_zodii_table_arr(i).nume_zodie_arr, l_items_zodii_table_arr(i).distributie_arr);
  end if;
end;
/
exec p_zodiac;
/
select * from zodii_distributii;


--2.Exemplu de functie care returneaza un array
--Creati o functie care sa intoarca o lista cu id-urile studentilor ce au luat 10 la Baze de date
create or replace function get_students_id return num_arr
is
  p_students_id_arr num_arr;
begin
  select student_id
  bulk collect into p_students_id_arr
  from
  (select s.id as student_id
  from studenti s join note n on n.id_student = s.id join cursuri c on c.id = n.id_curs
  where titlu_curs = 'Baze de date' and valoare = 10);
  return p_students_id_arr;
end;
/
select * from table (get_students_id) order by 1;
select nvl(column_value,0) from table(get_students_id) where column_value = 13;

/*3. Construiti o procedura (sau functie) care sa primeasca ca parametru o lista de obiecte de tip record care sa contina ID-uri de studenti si procentaj 
de marire a bursei. In cazul in care studentul nu avea bursa, i se va adauga o valoare minima (de 100) dupa care se va opera cresterea specificata. Procedura 
va face modificarile din lista primita ca parametru.*/
drop type studenti_burse;
drop type student_bursa;
/
create type student_bursa as object (id_student char(4), procent_marire number);
/
create type studenti_burse as table of student_bursa;
/
create or replace procedure mareste_bursa (pi_studenti studenti_burse) is
begin
  for c in (select id_student, procent_marire from table(pi_studenti)) loop
    update studenti 
    set bursa = nvl(bursa,100) * (1+c.procent_marire)
    where id = c.id_student;
  end loop;
end mareste_bursa;
/
select id,bursa from studenti where id in (1,3);
/
begin 
  mareste_bursa(studenti_burse(student_bursa(1,0.5),student_bursa(3,2)));
end;
/
select id,bursa from studenti where id in (1,3);
/
rollback;
