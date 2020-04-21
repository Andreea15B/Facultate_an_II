<?php

// o clasa pentru prelucrarea documentelor XML
// varianta pentru PHP 5.4+
// autor: Sabin-Corneliu Buraga (2000-2001, 2015, 2019)

class parseXML {
  private $xml_parser; /* instanta analizorului XML */
  private $xml_file;   /* numele fisierului XML */
  private $html_code;  /* codul HTML generat */
  private $open_tags;  /* multimea tag-urilor de inceput */
  private $close_tags; /* multimea tag-urilor de sfirsit */
 
  // constructor
  function __construct() {
    $this->xml_parser = "";
    $this->xml_file   = "";
    $this->html_code  = "";
    $this->open_tags  = [];
    $this->close_tags = [];
  }
  // destructor
  function __destruct() {
    if ($this->xml_parser)
      xml_parser_free($this->xml_parser); 
  }
  // metode
  // seteaza tag-urile de inceput
  public function set_open_tags($tags) {
    $this->open_tags = $tags;
  }  
  // seteaza tag-urile de sfirsit
  public function set_close_tags($tags) {
    $this->close_tags = $tags;
  }    
  // seteaza numele fisierului XML
  public function set_xml_file($file) {
    $this->xml_file = $file;
  }
  // furnizeaza codul HTML generat
  public function get_html_code() {
    return $this->html_code;
  }
  // tratarea evenimentului de 
  // aparitie a unui tag de inceput        
  private function start_element($parser, $name, $attrs) {
    if ($format = $this->open_tags[$name])
      $this->html_code .= $format;
  }    
  // tratarea evenimentului de 
  // aparitie a unui tag de sfarsit        
  private function end_element($parser, $name) {
    if ($format = $this->close_tags[$name])
      $this->html_code .= $format;
  }      
  // tratarea evenimentului de 
  // aparitie a unor date de tip caracter        
  private function character_data($parser, $data) {
    $this->html_code .= $data;
  }
  // functia de analiza propriu-zisa
  public function parse() {
    // instantiaza procesorul XML
    $this->xml_parser = xml_parser_create();  
    // inregistreaza functiile de analiza
    xml_set_object($this->xml_parser, $this);
    // seteaza optiunile de analiza 
    // (tag-urile nu sunt rescrise cu caractere mari)
    xml_parser_set_option($this->xml_parser, 
                          XML_OPTION_CASE_FOLDING, false);
    // seteaza functiile de procesare a elementelor XML                          
    xml_set_element_handler($this->xml_parser, 
                            "start_element", "end_element");
    xml_set_character_data_handler($this->xml_parser,
                            "character_data");
    
    // deschide fisierul XML
    if (!($fp = fopen($this->xml_file, "r"))) 
      die("could not open XML source");
    // proceseaza fisierul
    while ($data = fread($fp, 4096)) {
      if (!xml_parse($this->xml_parser, $data, feof($fp))) {
        // eroare de procesare
        die(sprintf("XML error: %s at line %d",
          xml_error_string(xml_get_error_code($this->xml_parser)),
          xml_get_current_line_number($this->xml_parser)));
      }
    }
  } // parse()
} // class
