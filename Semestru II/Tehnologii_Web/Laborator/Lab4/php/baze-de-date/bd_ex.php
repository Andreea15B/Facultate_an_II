<?php
/* Program PHP5 care exemplifica utilizarea unei clase de manipulare
   a bazelor de date MySQL
   
   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/ 
   2007, 2015, 2019
   
   Ultima actualizare: 6 martie 2015
*/
require_once ('bd.php'); // includem clasa definita in alt fisier

// instantiem obiectul
$bd = new DataBase_MySQL ('localhost', 'stud', 'utilizator', '');
// ne conectam la serverul MySQL 
$bd->connect(); 
// formulam interogarea SQL
$bd->query("select * from students where age >=21 order by name;"); 
?> 
<html> 
	<head><title>Studentii de peste 21 de ani</title></head>
	<body> 
		 <?php 
		 		# parcurgem toate înregistrarile gasite
		 		while ($bd->next_record()) { 
		 ?> 
		 <p><strong><?php print $bd->Record["name"]; ?></strong> 
		 din anul <?php print $bd->Record["year"]; ?>
		 are <?php print $bd->Record["age"]; ?> de ani.</p> 
		 <?php 
		    } # final de 'while' 
		 ?>
  </body>
</html>