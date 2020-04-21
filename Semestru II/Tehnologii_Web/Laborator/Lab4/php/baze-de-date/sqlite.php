<?php
/* Program PHP5 care ilustreaza utilizarea extensiei SQLite in conjunctie 
   cu procesarea XML simplificata
   
   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/
   2007, 2015
   
   Ultima actualizare: 10 martie 2015
*/   

// deschidem o baza de date SQLite (daca nu exista, va fi creata)
if (($bd = sqlite_open ('studenti', 0666, $eroare)) === FALSE) {
	die ($eroare);
}	

// cream o tabela
sqlite_exec ('CREATE TABLE students (name varchar(50), age smallint(2))', $bd);

// inseram date preluate dintr-un document XML
$xml = simplexml_load_file('punctaje.xml');
foreach ($xml->punctaj as $punctaj) {
	// obtinem numele studentilor pentru a-i insera in baza de date
  echo 'Am inserat o varsta pentru ' . $punctaj['stud'] . '<br />';
  // virstele se genereaza aleatoriu ;)
  sqlite_exec ("INSERT INTO students VALUES ('" . 
    $punctaj['stud'] . "'," . rand(10, 90) . ')', $bd);  
}

// selectam doar studentii cu varste cuprinse intre 20 si 50
$rezultate = sqlite_query (
  'SELECT * FROM students WHERE age < 50 and age > 20 ORDER BY age desc', $bd);

// generam o lista numerotata a rezultatelor
echo '<ol>';
while ($r = sqlite_fetch_array($rezultate)) {
  echo '<li>' . $r['name'] . ' are ' . $r['age'] . ' de ani.</li>';
}
echo '</ol>';

// inchidem baza de date SQLite
sqlite_close ($bd);
?>