------- Lab6 SELF JOIN ---------

4. Sa se afiseze cupluri de numere matricole impreuna cu un ID al unui curs astfel 
incat studentul avand primul numar matricol a luat nota strict mai mare decat studentul 
avand cel de-al doilea numar matricol la cursul cu ID-ul dat de cea de-a treia coloana.
Afisarea se va face doar pentru cursurile cu ID-urile 21 si 24. Coloanele se vor numi "M1", "M2", "curs". 

	SELECT n1.nr_matricol AS M1, n2.nr_matricol AS M2, n1.id_curs AS Curs
	FROM note n1 JOIN note n2 ON n1.valoare > n2.valoare AND n1.id_curs = n2.id_curs AND 
	n1.id_curs IN (21, 24);
	
5. Pentru cursul de BD, afisati toate perechile de studenti ce au luat note, dar fara a afisa duplicate.
Primul va fi afisat studentul ce a luat nota mai mare (iar daca sunt doi cu aceeasi cota, se vor afisa de doua ori,
adica si a cu b, dar si b cu a). Afisati si notele !

	SELECT s1.nr_matricol || ' ' || s1.nume || ' ' || n1.valoare AS std1,
	s2.nr_matricol || ' ' || s2.nume || ' ' || n2.valoare AS std2 FROM studenti s1
	JOIN note n1 ON s1.nr_matricol = n1.nr_matricol JOIN studenti s2 ON s1.nr_matricol > s2.nr_matricol
	JOIN note n2 ON s2.nr_matricol = n2.nr_matricol JOIN cursuri c ON c.id_curs = n1.id_curs
	AND n1.valoare >= n2.valoare AND c.id_curs = n2.id_curs AND c.titlu_curs = 'BD';
	
7. Selectati perechile de cursuri (adica titlurile lor) la care s-a pus acelasi numar de note in sesiunile din anul 2014.
Prima coloana se va numi "Pereche", iar cursul 1 va fi concantenat cu cursul 2 printr-un spatiu.
A doua coloana se va numi "Sesiune", iar o sesiune este identificata prin luna si an (vezi lab 5, de exemplu FEBRUARY, 2014).
Atentie la spatiul dintre luna si an ! Eliminati duplicatele.
	
	SELECT DISTINCT c1.titlu_curs || ' ' || c2.titlu_curs AS "Pereche", TRIM(TO_CHAR(n1.data_notare, 'MONTH')) || ' ' ||
	EXTRACT(year FROM n1.data_notare) AS Sesiune FROM cursuri c1 JOIN note n1 ON c1.id_curs = n1.id_curs 
	JOIN cursuri c2 ON c1.id_curs > c2.id_curs JOIN note n2 ON c2.id_curs = n2.id_curs WHERE 
	EXTRACT(year FROM n1.data_notare) = 2014 AND EXTRACT(year FROM n2.data_notare) = 2014
	HAVING COUNT(c1.id_curs) = COUNT(c2.id_curs) GROUP BY c1.titlu_curs, c2.titlu_curs, n1.data_notare, n2.data_notare;
	
8. Afisati toate perechile de profesori ce nu au grad didactic. Eliminati duplicatele.
Prima coloana se va numi "prof1", iar a doua se va numi "prof2".

	SELECT DISTINCT p1.nume || ' ' || p1.prenume AS Prof1, p2.nume || ' ' || p2.prenume AS Prof2
	FROM profesori p1 JOIN profesori p2 ON p1.id_prof < p2.id_prof
	WHERE p1.grad_didactic IS NULL AND p2.grad_didactic IS NULL;
	
9. Afisati perechile de cursuri la care s-a pus cel putin o nota de 10. Eliminati duplicatele.
Vor fi deci doua coloane, numite "Curs1" si "Curs2".

	SELECT DISTINCT c1.titlu_curs AS Curs1, c2.titlu_curs AS Curs2 FROM cursuri c1 JOIN cursuri c2 ON c1.id_curs < c2.id_curs
	JOIN note n1 ON c1.id_curs = n1.id_curs JOIN note n2 ON c2.id_curs = n2.id_curs WHERE n1.valoare = 10 AND
	n2.valoare = 10;
	
10. Afisati perechile de cursuri la care nu s-a pus nici o nota. Eliminati duplicatele.
Vor fi deci doua coloane, numite "Curs1" si "Curs2".
	
	SELECT DISTINCT c1.titlu_curs, c2.titlu_curs FROM cursuri c1 JOIN cursuri c2 ON c1.id_curs < c2.id_curs LEFT JOIN
	note n1 ON c1.id_curs = n1.id_curs LEFT JOIN note n2 ON c2.id_curs = n2.id_curs;

12. Afisati perechile de profesorii ce nu tin nici un curs. Eliminati duplicatele.
	
	SELECT p1.nume, p1.prenume AS prof1, p2.nume, p2.prenume AS prof2 FROM profesori p1 
	JOIN profesori p2 ON p1.id_prof < p2.id_prof LEFT JOIN didactic d1 ON p1.id_prof = d1.id_prof
	LEFT JOIN didactic d2 ON p2.id_prof = d2.id_prof WHERE d1.id_prof IS NULL AND d2.id_prof IS NULL;
	
13. Afisati perechile de studenti ce au aceeasi nota la materiile din anul 1. Eliminati duplicatele.
Afisati si cursurile si notele ! Sunt deci doar 2 coloane. Coloanele se vor numi "student1" si "student2"

	SELECT s1.nr_matricol || ' ' || s1.nume || ' ' || c1.titlu_curs || ' ' || n1.valoare AS std1,
	s2.nr_matricol || ' ' || s2.nume || ' ' || c2.titlu_curs || ' ' || n2.valoare AS std2 FROM studenti s1,
	studenti s2, cursuri c1, cursuri c2, note n1, note n2 WHERE s1.nr_matricol < s2.nr_matricol AND
	s1.nr_matricol = n1.nr_matricol AND s2.nr_matricol = n2.nr_matricol AND c1.id_curs = n1.id_curs AND
	c2.id_curs = n2.id_curs AND c1.an = 1 AND c2.an = 1 AND n1.valoare = n2.valoare;
	