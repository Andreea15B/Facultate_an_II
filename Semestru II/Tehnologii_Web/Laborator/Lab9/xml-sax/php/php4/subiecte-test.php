<?php
  // exemplu de procesare SAX folosind PHP si Expat
  // pentru a afisa propuneri de subiecte de examen
  
  require("parseXML.php");

  // substitutia elementelor XML cu cod HTML
  // se folosesc doua tablouri asociative
  $open_tags = array(
    'subiecte' => "\n<!-- generat de parseXML -->\n" .
       '<section><ol>',
    'subiect' => '<li>');
  $close_tags = array(
    'subiecte' => "</ol></section>\n" . 
       "<!-- sfarsitul generarii parseXML -->\n",
    'subiect' => '</li>');

  // instantiaza si initializeaza analizorul    
  $parser = new parseXML();
  $parser->set_xml_file('web-test.xml');
  $parser->set_open_tags($open_tags);
  $parser->set_close_tags($close_tags);
  // ruleaza analizorul
  $parser->parse();
  // afiseaza rezultatul
  echo $parser->get_html_code();
  // distruge obiectul
  $parser->destroy();
?>