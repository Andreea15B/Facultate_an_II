<?php
/* Program PHP5 care va prelua informatii dintr-o baza de date SQLite, 
   pentru a genera un arbore DOM caruia ii vom aplica o transformare XSLT, 
   obtinindu-se un continut XHTML
  
   Autor: Sabin-Corneliu Buraga (2009, 2011) -- http://www.purl.org/net/busaco 
   Ultima actualizare: 05 aprilie 2011
*/

  // nume de pinguini 
  $numePinguini = array ('Pingut', 'Tuxin', 'Pingux', 'Tuxana', 'Tugdan', 
                          'Taxu', 'Adyx', 'Pinguana', 'Sinmax', 'Tooxa');

  try {
  	// instantiem un obiect SQLite -- stocare in memorie
    $date = new SQLiteDatabase (':memory:');
    // cream o tabela ce va contine date despre pinguini
    $date->queryExec 
      ('CREATE TABLE penguins (name varchar(20), age smallint(2))'); 
    // populam cu date tabela
    foreach ($numePinguini as $nume) {
    	$date->queryExec ("INSERT INTO penguins VALUES ('" . $nume . 
    	  "', " . rand(14, 60) . ')'); // varsta e generata aleatoriu
    }
     
    // cream un document XML pe care-l vom popula 
    // cu datele preluate din tabela de mai sus
    $doc = new DOMDocument ('1.0', 'utf-8');
    $doc->formatOutput = true; // indenteaza documentul XML la iesire
    $radacina = $doc->createElement ('penguins');
    $doc->appendChild ($radacina);
    
    // selectam doar pinguinii tineri
    $rez = $date->query (
      'SELECT name, age FROM penguins WHERE age < 40 ORDER BY age DESC');
    // preluam datele intr-un tablou asociativ...
    $pinguiniTineri = $rez->fetchAll (SQLITE_ASSOC);
    // ...si cream documentul via DOM
    foreach ($pinguiniTineri as $pinguin) {
      // pentru fiecare cimp, generam elementele XML
      $nodPinguin = $doc->createElement ('penguin');
      $nodPinguin = $radacina->appendChild ($nodPinguin);
      foreach (array_keys ($pinguin) as $cimp) {
        // adaugam un nod de tip element
        $nod = $doc->createElement ($cimp);
        $nod = $nodPinguin->appendChild ($nod);
        // acestui nod ii asociem drept continut 
        // valoarea cimpului preluat din baza de date
        $text = $doc->createTextNode ($pinguin[$cimp]);
        $text = $nod->appendChild ($text);
      }        
    }
    
    // afisam documentul rezultat
    echo '<pre>' . htmlentities ($doc->saveXML ()) . '</pre>';
    
    // efectuam si o transformare XSL
    // folosind procesorul XSLT
    $transf = new DomDocument;
    $transf->load ('penguins.xsl'); 
    $proc = new xsltprocessor;
    $proc->importStyleSheet ($transf); // atasam foaia de stiluri 
  
    echo $proc->transformToXML($doc);  // afisam rezultatul transformarii    
  }    
  catch (Exception $e) { // a aparut o exceptie
  	die('Din pacate, avem o problema... ' . $e->getMessage());  	
  }  
?>