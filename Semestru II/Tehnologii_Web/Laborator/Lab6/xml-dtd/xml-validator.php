<?php
// Valideaza un document XML conform unei scheme XML
// (functioneaza in PHP 5+)
// Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/
// Ultima actualizare: 30 martie 2018

// Functie de validare a unui document XML
function valideazaXML ($tipValidare, $xml, $specificatie = '') {
  try {
     // Incarcam un document $xml...
     $doc = @DOMDocument::load ($xml);
     // si incercam sa-l validam folosind $specificatie,
     // conform unui tip de validare dat de $tipValidare
     switch ($tipValidare) {
  	   case 'DTD': return $doc->validate ();
  	   case 'XSD': return $doc->schemaValidate ($specificatie);
  	   case 'RNG': return $doc->relaxNGValidate ($specificatie);
  	   default:    return FALSE;
     }
  }
  catch (Exception $e) {
     echo 'A aparut o exceptie la validarea documentului XML :( ' . $e->getMessage();
  }  
}

// "Programul principal"

// validam un document conform unui DTD intern
echo '<p>Documentul privind proiectele este ' . 
  (valideazaXML ('DTD', 'projects/projects-dtd.xml') ?
  'valid' : 'invalid') . ' conform DTD-ului intern.</p>';  

// validam un document conform unui DTD extern
echo '<p>Documentul privind cuprinsul este ' . 
  (valideazaXML ('DTD', 'cuprins/cuprins-dtd.xml') ?
  'valid' : 'invalid') . ' conform DTD-ului.</p>';  

?>