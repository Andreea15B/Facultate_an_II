<?php
  // exemplu de procesare SAX folosind PHP si Expat
  // pentru a afisa impresiile referitoare la un sit Web
  // autor: Sabin-Corneliu Buraga <busaco@infoiasi.ro> (c)2000-2001, 2007
  
  require("parseXML.php");

  // substitutia elementelor XML cu cod HTML
  // se folosesc doua tablouri asociative
  $open_tags = array(
    "impresii" => "\n<!-- generat de parseXML -->\n" .
       '<table style="width: 500px;border: solid 1px navy" summary="impresii">',
    "impresie" => '<tr style="vertical-align: middle">',
    "nume" => "<td><h3>",
    "ocupatia" => '<td><p style="color: blue">',
    "virsta" => "<td><p><em>",
    "text" => '<td style="background: #EEE"><p style="padding: 1em">');
  $close_tags = array(
    "impresii" => "</table>\n" . 
       "<!-- sfirsitul generarii parseXML -->\n",
    "impresie" => "</tr>",
    "nume" => "</h3></td>",
    "ocupatia" => "</p></td>",
    "virsta" => "</em></p></td>",
    "text" => "</p></td>");

  // instantiaza si initializeaza analizorul    
  $parser = new parseXML();
  $parser->set_xml_file("impresii.xml");
  $parser->set_open_tags($open_tags);
  $parser->set_close_tags($close_tags);
  // ruleaza analizorul
  $parser->parse();
  // afiseaza rezultatul
  echo $parser->get_html_code();
  // distruge obiectul
  $parser->destroy();
?>