<?php
  /* Un program PHP4 ilustrand maniera standard de interogare 
     a serverului MySQL
     
     Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/ 
     2001, 2007-2008
   
     Ultima actualizare: 29 februarie 2008
  */    
  // conectarea la serverul MySQL
  $conexiune = mysql_connect (
    'localhost', // locatia serverului (aici, masina locala)
    'tux',       // numele de cont
    'p@rola'     // parola
  );
  // verificam daca am reusit
  if (!$conexiune) {
  	die ('A survenit o eroare de conectare: ' . mysql_error());
  }
  // deschidem baza de date 
  if (!mysql_select_db('students', $conexiune)) {
    die ('Baza de date nu poate fi deschisa: ' . mysql_error());
  } 
  // formulam o interogare...  
  $sql = "select name, year from students where year = 2";
  // ...si o executam
  $interog = mysql_query ($sql, $conexiune);
  if (!$interog) {
  	die ('A survenit o eroare la interogare: ' . mysql_error());
  }
  // salvam intr-un tablou inregistrarile gasite 
  $inreg = mysql_fetch_array ($interog);
  // baielam tabloul...
  echo ('<ol>');
  while ($inreg) {
  	echo ('<li>Studentul ' . $inreg['name'] . 
  	  ' este in anul ' . $inreg['year'] . '</li>');
  	$inreg = mysql_fetch_array ($interog);
  }
  echo ('</ol>');
  // am terminat
  mysql_close($conexiune);
?>