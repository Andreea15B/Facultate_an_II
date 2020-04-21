<!DOCTYPE html>
<html>
<head>
<title>Nume si varsta</title>
<style>
body {
  width: 50em;
}
.mesaj {
  color: red;
  font-weight: bold;
}
</style>
</head>
<body>
<?php 
/* Program PHP scufundat intr-un document HTML, 
   folosit la exemplificarea preluarii datelor receptionate 
   via un formular Web -- exemplu de cod de tip spaghetti (nerecomandat!)
   
   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/
   2014, 2015, 2017, 2019

   Ultima actualizare: 6 martie 2017 
*/
   
   if (!$_REQUEST["nume"]) { // verificam daca s-a preluat numele
?> 
   <p class="mesaj">Nu ati specificat numele!</p> 
<?php 
   } 
   else { 
     echo ("<p>Numele d-voastra este <em>" . $_REQUEST["nume"] . "</em>.</p>"); 
   }
   // verificam daca s-a furnizat varsta
   $varsta = $_REQUEST["varsta"];
   if (!$varsta || $varsta < 0 || $varsta > 90) {
?> 
   <p class="mesaj">Varsta d-voastra e dubioasa!</p> 
<?php 
   } 
   else { 
     echo ("<p>Pretindeti ca aveti " . $varsta . " de ani...</p>"); 
   }
?>
<hr />
</body>
</html>