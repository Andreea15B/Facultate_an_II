<?php
/** Un program PHP5 care utilizeaza PDO (PHP Data Objects)
    pentru accesul la un sistem de baze de date relationale
    (aici, MySQL/MariaDB) -- detalii in prelegerea de la curs:
	https://profs.info.uaic.ro/~busaco/teach/courses/web/web-film.html#week5

	Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/

	Ultima actualizare: 16 martie 2017 
**/

// datele de conectare la serverul de baze de date
$host = '127.0.0.1';
$db   = 'students';
$user = 'tux';
$pass = 'p@r0la';
$charset = 'utf8';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";

// optiuni vizand maniera de conectare
$opt = [
	// erorile sunt raportate ca exceptii de tip PDOException
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    // rezultatele vor fi disponibile in tablouri asociative
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    // conexiunea e persistenta
    PDO::ATTR_PERSISTENT 		 => TRUE
];

// preluam de la clientul Web anul (implicit: 2)
$year = $_REQUEST['year'] ? $_REQUEST['year'] : 2; // PHP 7: $_REQUEST['year'] ?? 2

try {
	// instantiem un obiect PDO
  	$pdo = new PDO ($dsn, $user, $pass, $opt);

  	// pregatim comanda SQL parametrizata
  	$sql = $pdo->prepare ('SELECT year, name, age FROM students WHERE year=? ORDER BY age');

  	// daca s-a putut executa...
	if ($sql->execute ([$year])) {
		// ...preluam fiecare inregistrare gasita
  		while ($row = $sql->fetch()) {
  			// ...si o afisam (coloana tabelei e cheie a tabloului asociativ)
    		echo '<p>' . $row['name'] . ' e in anul ' . $row['year'] . '.</p>';
    	}	
  	}
  } catch (PDOException $e) {
  	echo "Eroare: " . $e->getMessage(); // mesajul exceptiei survenite
};

