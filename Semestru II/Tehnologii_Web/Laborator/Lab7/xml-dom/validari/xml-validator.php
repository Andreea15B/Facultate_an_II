<?php
/* Program PHP ce valideaza un document XML 
  
   Autor: Sabin-Corneliu Buraga <https://profs.info.uaic.ro/~busaco/>
   Ultima actualizare: 24 aprilie 2018
*/   

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

// validam un alt document conform unui DTD extern
echo '<p>Documentul privind cuprinsul este ' . 
  (valideazaXML ('DTD', 'cuprins/cuprins-dtd.xml') ?
  'valid' : 'invalid') . ' conform DTD-ului.</p>';  

// validam un document conform unei scheme XML
echo '<p>Documentul cu proiecte este ' . 
  (valideazaXML ('XSD', 'projects/projects-xsd.xml', 'projects/projects.xsd') ?
  'valid' : 'invalid') . ' conform schemei XML.</p>';
  
// validam un document conform unei scheme RELAX NG
echo '<p>Documentul cu poeme este ' . 
  (valideazaXML ('RNG', 'antologie/antologie.xml', 'antologie/antologie.rng') ?
  'valid' : 'invalid') . ' conform schemei RELAX NG.</p>';   
?>