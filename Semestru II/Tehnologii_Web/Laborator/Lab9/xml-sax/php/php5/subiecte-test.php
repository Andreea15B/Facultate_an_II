<?php
  // exemplu de procesare SAX folosind clasa de procesare SAX (parseXML.php)
  // pentru a afisa propuneri de subiecte de teste scrise -- varianta PHP 5.4+
  // autor: Sabin Buraga (2013, 2019)
  
  require("parseXML.php");

  // substitutia elementelor XML cu cod HTML
  // se folosesc doua tablouri asociative
  $open_tags = [
    'subiecte' => "<!-- parseXML --><section><ol>",
    'subiect'  => "<li>" 
  ];
  $close_tags = [
    'subiecte' => "</ol></section><!-- /parseXML -->",
    'subiect'  => "</li>"
  ];

  // instantiaza si initializeaza analizorul    
  $parser = new parseXML();
  $parser->set_xml_file('web-test.xml');
  $parser->set_open_tags($open_tags);
  $parser->set_close_tags($close_tags);
  // ruleaza analizorul
  $parser->parse();
  // redarea rezultatului
  echo $parser->get_html_code();
  