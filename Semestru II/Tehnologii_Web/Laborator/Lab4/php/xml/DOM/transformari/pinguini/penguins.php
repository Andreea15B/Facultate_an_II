<?php
  // Program PHP5 care va prelua informatii dintr-o baza de date SQLite, 
  // pentru a genera un arbore DOM caruia ii vom aplica o transformare XSLT, 
  // obtinindu-se un continut XHTML
  // Ultima actualizare: 20 martie 2009
  // Autor: Sabin-Corneliu Buraga - http://www.infoiasi.ro/~busaco/ 
    
  // nume de pinguini 
  $nume_pinguini = array ('Pingut', 'Tuxin', 'Pingux', 'Tuxana', 'Tugdan', 
                          'Taxu', 'Adyx', 'Pinguana', 'Sinmax', 'Tooxa');

  try {
  	// instantiem un obiect SQLite -- stocare in memorie
    $date = new SQLiteDatabase (':memory:');
    // cream o tabela ce va contine date despre pinguini
    $date->queryExec 
      ('CREATE TABLE penguins (name varchar(20), age smallint(2))'); 
    // populam cu date tabela
    foreach ($nume_pinguini as $nume) {
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
    $pinguini_tineri = $rez->fetchAll (SQLITE_ASSOC);
    // ...si cream documentul via DOM
    foreach ($pinguini_tineri as $pinguin) {
    	// pentru fiecare cimp, generam elementele XML
      $nod_pinguin = $doc->createElement ('penguin');
      $nod_pinguin = $radacina->appendChild ($nod_pinguin);
      foreach (array_keys ($pinguin) as $cimp) {
        // adaugam un nod de tip element
        $nod = $doc->createElement ($cimp);
        $nod = $nod_pinguin->appendChild ($nod);
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