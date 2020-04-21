------------Laborator 2---------------

1. SELECT nume, prenume, an, data_nastere FROM studenti ORDER BY 1;

2. SELECT DISTINCT bursa FROM studenti WHERE bursa!=0 AND bursa IS NOT NULL ORDER BY 1 DESC;

4. SELECT nume || ' ' || prenume || ',' || an AS "Studenti pe an de studiu" FROM studenti
ORDER BY an;

5. SELECT nume || prenume || data_nastere FROM studenti 
WHERE data_nastere BETWEEN '01-JAN-1995' AND '10-JUN-1997' ORDER BY an DESC;

6. SELECT nume, prenume, an FROM studenti WHERE EXTRACT(year FROM data_nastere)=1995;

8. SELECT nume, prenume FROM studenti WHERE bursa IS NOT NULL AND (an=2 OR an=3);

10. SELECT * WHERE nume LIKE 'P%' AND an=1 FROM studenti;

11. SELECT * WHERE nume LIKE '%a%a%' FROM studenti;

13. ...WHERE grupa LIKE 'A_' AND bursa IS NOT NULL;

14. ...WHERE TRIM(prenume) LIKE '%n';