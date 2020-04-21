/*1. Creati o tabela ce va contine studentii ce au fost plecati cu o bursa erasmus care sa contina numarul matricol,
numele si prenumele studentilor care au plecat in Erasmus impreuna cu un camp nou care sa indice tara in care au plecat (de exemplu printr-un ID numeric).
--a.Creati un index unic peste coloana reprezentand numarul matricol din noua tabela.
--b.Copiati in tabela nou creata 100 de studenti din tabela studenti alesi in mod aleatoriu si
respectand conditia de unicitate de la punctul 1. Dintre cei 100 de studenti numai cativa vor putea fi copiati, unii vor fi deja existenti in tabela 
cea noua si vor genera exceptii.
--c.Afisati studentii care au fost copiati cu succes si pe cei care nu au putut fi copiati.*/
--dupa cum vedeti este chiar problema 1 din documentul wiki
drop table studenti_erasmus;
/
create table studenti_erasmus(
  nr_matricol varchar2(6),
  nume varchar2(15),
  prenume varchar2(30),
  id_tara int,
  copiat number(1));
/
drop index emp_name_idx;
/
create unique index nr_matricol_idx on studenti_erasmus(nr_matricol);
/
declare
  v_studenti_copiati clob; --am ales tipul de data clob deoarece vom avea 100 de inregistrari, deci un numar foarte mare de caractere
  v_studenti_necopiati clob;
  v_count number :=0;
  v_count_copiati number :=0;
  cursor c1 is
  select nr_matricol,nume,prenume
  from studenti
  order by 1;
begin
  --delete from studenti_erasmus;
  for c1_record in c1 loop
    begin
      insert into studenti_erasmus(nr_matricol,nume,prenume,id_tara) values (c1_record.nr_matricol,c1_record.nume,c1_record.prenume,dbms_random.value(1,10));
      v_count := v_count + 1;
      
      --initial le punem la toti flagul cu 1, adica presupunem ca au fost toti copiati
      update studenti_erasmus
      set copiat=1
      where nr_matricol=c1_record.nr_matricol;
      v_studenti_copiati:=v_studenti_copiati||' , '||c1_record.nume||'.'||c1_record.prenume;
    exception
      when dup_val_on_index then
        update studenti_erasmus
        set copiat=0
        where nr_matricol=c1_record.nr_matricol;
        v_studenti_necopiati:=v_studenti_necopiati||' , '||c1_record.nume||'.'||c1_record.prenume;
      end;
      exit when v_count =100;--copiem doar 100
  end loop;    
 
  v_studenti_copiati := ltrim(v_studenti_copiati,' , ');
  v_studenti_necopiati := ltrim(v_studenti_necopiati,' , ');
  dbms_output.put_line('Studenti copiati cu succes: ' || v_studenti_copiati);  
  dbms_output.put_line('Au fost copiati cu succes '||v_count||' studenti.');
  dbms_output.put_line('Studenti necopiati: ' || v_studenti_necopiati); 
end;  
/  
select count(*) from studenti_erasmus;
select * from studenti_erasmus;


--2.Creati specificatia si corpul unui pachet numit student_pack si care sa contina procedurile: add_stud, upd_stud si del_stud foaie_stud. 
--primele 3 proceduri creeaza operatii DML, iar ultima intoarce foaia matricola a unui student pe baza id-ului sau
create or replace package stud_pack is
  procedure add_stud (IN_student_id in studenti.id%type, IN_nr_matricol studenti.nr_matricol%type, IN_student_name in studenti.nume%type, IN_student_prenume in studenti.prenume%type);
  procedure upd_stud (IN_student_id in studenti.id%type, IN_student_an in studenti.nume%type);
  procedure del_stud (IN_student_id in studenti.id%type);
  procedure foaie_stud (IN_student_id in studenti.id%type);
end;
/
create or replace package body stud_pack
is

procedure add_stud (IN_student_id in studenti.id%type, IN_nr_matricol studenti.nr_matricol%type, IN_student_name in studenti.nume%type, IN_student_prenume in studenti.prenume%type)
is
begin
  insert into studenti(id,nr_matricol,nume,prenume) values(IN_student_id, IN_nr_matricol, IN_student_name, IN_student_prenume);
exception
  when dup_val_on_index then
  dbms_output.put_line('Studentul cu id-ul ' ||IN_student_id||' exista in baza de date! ');
end add_stud;

procedure upd_stud (IN_student_id in studenti.id%type, IN_student_an in studenti.nume%type)
is
  e_nu_exista exception;
begin
  update studenti set an=IN_student_an where id=IN_student_id;
  if sql%notfound then 
    raise e_nu_exista;
  end if;
exception
  when e_nu_exista then
  dbms_output.put_line('Studentul cu id-ul '||IN_student_id||' nu se regaseste in baza de date ! ');
  dbms_output.put_line(sqlcode||'  '||sqlerrm);--afisez si codul de eroare Oracle
end upd_stud; 

procedure del_stud (IN_student_id in studenti.id%type)
is
  e_del_stud exception;
begin
  delete from prieteni where id = IN_student_id;
  delete from note where id = IN_student_id;
  delete from studenti where id=IN_student_id;
  if sql%notfound then
    raise e_del_stud;
  end if;
exception
  when e_del_stud then
  dbms_output.put_line('Studentul cu id-ul '||IN_student_id||' nu se regaseste in baza de date !');
end del_stud;  

procedure foaie_stud (IN_student_id in studenti.id%type)
is
  p_counter integer;
  p_daca_exista boolean;
  p_mesaj varchar2(100);
  cursor c1 is 
  select titlu_curs,valoare,c.an,s.nume as numes,s.prenume as prenumes
  from cursuri c join note n on c.id=n.id_curs join studenti s on s.id=n.id_student
  where s.id=IN_student_id
  order by 3;
  begin
    p_daca_exista:=f_exista_student(IN_student_id); --avem deja stocata aceasta functie de la un laborator anterior
    if p_daca_exista=true then
      for c1_record in c1 loop
        p_mesaj:=('Curs '||c1_record.titlu_curs ||' Nota '||c1_record.valoare||' An '||c1_record.an);
        dbms_output.put_line(p_mesaj);
      end loop;
    end if;
end foaie_stud;  

end stud_pack; --am inchis intreg pachetul
/
--apelul 
exec stud_pack.add_stud(1,'ABC','Ionescu','Gigel');
exec stud_pack.add_stud(71711,'XYZ','Ion','Gigi');
/
select * from studenti where id = 71711;--dovada ca s-a inserat
/
exec stud_pack.upd_stud(71711,1);
/
exec stud_pack.del_stud(71712);
/
exec stud_pack.foaie_stud(1);