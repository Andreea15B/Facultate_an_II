<?php
/* Un program PHP care proceseaza un document XML folosind modelul DOM
   Functioneaza pentru PHP versiunea 5.x
   
   Autor: Sabin-Corneliu Buraga (2004, 2007, 2011)
   Ultima actualizare: 05 aprilie 2011
*/     
// locul unde sunt stocate fisierele
define ("PATH", ''); 
# De exemplu, pentru Windows cu EasyPHP instalat in 'Program Files\EasyPHP':
# define ("PATH", 'c:\\Program Files\\EasyPHP\\www\\');

// variabila globala indicand daca a fost modificat documentul
$modified = 0;

// instantiem un obiect reprezentand arborele DOM
$doc = new DomDocument;
try {
  // incarcam documentul XML
  $doc->load (PATH . "projects.xml");

  // afisam informatii privitoare la proiecte
  $projs = $doc->getElementsByTagName("project");
  foreach ($projs as $proj) {
    // preluam nodurile <title>	
    $titles = $proj->getElementsByTagName("title");
    foreach ($titles as $title) {
      echo "<p>Proiect: " . $title->nodeValue;
    }		
    // verificam care e clasa proiectului
    if ($proj->hasAttribute("class")) {
      echo " de clasa " . $proj->getAttribute("class") . "</p>";
    }	
    else {
      echo " de clasa necunoscuta.</p>";
      // nu exista atributul "class", il cream
      // implicit, proiectul e de clasa D :)
      $attr = $proj->setAttribute("class", "D");
      // marcam documentul ca fiind modificat
      $modified = 1;
    }	
  }

  // daca documentul a fost modificat, il afisam
  if ($modified) {
    $xmldoc = $doc->saveXML();
    echo "<pre>" . htmlentities($xmldoc) . "</pre>";  	
  }
} 
catch (Exception $e) {
	die ("A survenit o exceptie...");
}
?>