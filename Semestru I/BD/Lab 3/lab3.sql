
/*7.Pentru fiecare student afi?a?i numele, data de nastere, data la care studentul urmeaza sa isi sarbatoreasca ziua de nastere si prima zi de duminicã de dupa.*/
--floor(floor(months_between(current_date,data_nastere)/12)*12)+12) intoarce nr de luni de la nasterea studentului
select nr_matricol,nume,data_nastere,
	add_months(data_nastere,floor(floor(months_between(current_date,data_nastere)/12)*12)+12) as sarbatoare,
	next_day(add_months(data_nastere,(floor(floor(months_between(current_date,data_nastere)/12)*12)+12)),'SUNDAY') as prima_duminica_dupa
from studenti
order by 1;

--varianta in care folosim pentru rotunjire functia ceil
column nr_matricol format A11
column data_nastere format A15
column sarbatoare format A12
column prima_duminica_dupa format A25
select nr_matricol,nume,data_nastere,
	add_months(data_nastere,ceil(ceil(months_between(current_date,data_nastere)/12)*12)) as sarbatoare,
	next_day(add_months(data_nastere,ceil(ceil(months_between(current_date,data_nastere)/12)*12)),'SUNDAY') as prima_duminica_dupa
from studenti
order by 1;


/*11.Afi?a?i pentru fiecare student numele, vârsta acestuia la data curentã sub forma '<x> ani <y> luni ?i <z> zile'
(de ex '19 ani 3 luni ?i 2 zile') ?i numãrul de zile pânã î?i va sãrbãtori (din nou) ziua de na?tere.*/
column nr_matricol format A3
column nume format A8
column prenume format A9
column varsta format A25
column nr_zile format A30
select nr_matricol,nume,prenume,
  trunc(months_between(sysdate,data_nastere)/12)||' ani '||
  floor(to_number(months_between(sysdate,data_nastere)-(trunc(months_between(sysdate,data_nastere)/12))*12))||' luni '||
  floor(to_number(sysdate-add_months(data_nastere,trunc(months_between(sysdate,data_nastere)))))||' zile. ' as varsta,
  floor(to_number(add_months(data_nastere,ceil(months_between(sysdate,data_nastere)/12)*12)-sysdate))||' zile pana la urmatoarea zi de nastere ' as nr_zile
from studenti
order by 1;


--Interogari suplimentare
--intrebari din anii trecuti selectate de pe platforma 
--exemplu de utilizare a functiei nullif
/*1.Sa se compare lungimea numelui cu lungimea prenumelui pentru fiecare student, iar in cazul in care acestea sunt egale se 
returneaza null, altfel se returneaza lungimea data de prenume. Deci se vor afisa in ordine:
prenumele studentului, nr de caractere al prenumelui, numele studentului si nr de caractere al numelui*/


/*2.Considerand ca in USA varsta majoratului este 21, identificati studentii care au cel putin 21 de ani impliniti. Afisati numele concatenat cu prenumele.*/


/*Selectati titlul,anul si numarul de credite pentru fiecare curs sub formatul : 'Cursul <titlu_curs> se face in anul <an> si are un numar de <credite> credite.'
pentru cursurile care se fac in semestrul 1 (indiferent de anul de studiu) si al carui titlu se scrie cu caractere majuscule. Denumiti coloana "Curs".*/


/*3.Afisati doar pentru studentii bursieri numele ("Nume"), prenumele ("Prenume") si data nasterii ("Data nasterii") 
folosind un numãr minim de functii, unde data nasterii are un format precum acesta: 
"Vineri , 17 Februarie 1995". Ordonati studentii crescãtor în functie anul si luna în care s-au nãscut.*/


/*4.Sa se afiseze suma dintre valoare si nr_matricol din tabelul Note intr-o coloana numita "SUMA". 
In alta coloana numita "NOTA" se va regasi 'x' daca suma aceasta este para; altfel, nota ramane neschimbata. 
Sa se ordoneze descrescator dupa SUMA. (Exemplu: 128 x sau 127 8) (Hint: functia DECODE)*/


/*5.Afisati numele si prenumele (concatenate cu un spatiu) în coloana "Student", iar în coloana "Bursa" afisati bursa fiecãrui student înmultitã
cu codul ascii al primei litere din prenumele studentului. Pentru cei care nu iau bursã se va afisa doar codul Ascii. 
Ordonati rezultatele crescãtor dupã nume. Ex: (Arhire Alexandra 65, Cobzaru George 24850).*/



 
