<?php
  // Program PHP4 care va prelua informatii dintr-o baza de date MySQL, 
  // pentru a genera un arbore DOM caruia ii vom aplica o transformare XSLT, 
  // obtinindu-se un continut XHTML reprezentabil în browser
  // Autor: (c)2004 Sabin-Corneliu Buraga - http://www.infoiasi.ro/~busaco/
  
  // functie de raportare a erorilor
  function raport_eroare ($mesaj) {
    echo '<p class="eroare">' . $mesaj . '<br />' .
      mysql_error () . '</p>';
    exit();
  }

  // ne conectam la serverul de baze de date
  $date = @mysql_connect ("127.0.0.1", "busaco", "p@ROLA!");
  if (!$date) 
    raport_eroare ("Eroare la conectare");

  // selectam baza de date
  if (!@mysql_select_db ("pub")) 
    raport_eroare ("Eroare la selectarea bazei de date");  

  // executam interogarea SQL  
  $rezultat = @mysql_query ("select autor, titlu, colectie " .
    "from volume order by titlu");
  if (!$rezultat)
    raport_eroare ("Eroare la interogare");

  // cream un document XML cu radacina <carti>
  $doc = domxml_new_doc ("1.0");
  $radacina = $doc->create_element ("carti");
  $radacina = $doc->append_child ($radacina); 

  // preluam datele si cream documentul via DOM 
  while ($carti = @mysql_fetch_array ($rezultat, MYSQL_ASSOC)) {
    // pentru fiecare cimp, generam elementele XML
    $nod_carte = $doc->create_element ("carte");
    $nod_carte = $radacina->append_child ($nod_carte);
    foreach (array_keys ($carti) as $cimp) {
      // adaugam un nod de tip element
      $nod = $doc->create_element ($cimp);
      $nod = $nod_carte->append_child ($nod);
      // acestui nod ii asociem drept continut 
      // valoarea cimpului preluat din baza de date
      $text = $doc->create_text_node ($carti[$cimp]);
      $text = $nod->append_child ($text);
    } 
  }
  mysql_close();

  // afisam documentul rezultat
  echo '<pre>' . htmlentities ($doc->dump_mem (TRUE)) . '</pre>';
  // efectuam si o transformare XSL
  // initializam procesorul XSLT
  $proc = xslt_create();
  // incarcam foaia de stiluri
  $xsl = @domxml_open_file ("carti.xsl");
  // cream un tablou care va contine documentele XML si XSLT
  // preluate din arborii DOM
  $argum = array ( 
    '/_xml' => $doc->dump_mem (), // continut XML
    '/_xsl' => $xsl->dump_mem ()  // continut XSL
  );
  // afisam rezultatul transformarii XSLT
  $rezultat = @xslt_process ($proc, 'arg:/_xml', 'arg:/_xsl', 
    NULL, $argum);
  echo $rezultat;
?>