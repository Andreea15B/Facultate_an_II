<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
  <title>Impresii</title>
  <style type="text/css">
  	table { width: 500px; border: solid 1px navy; }
    tr {vertical-align: middle; }
    p { padding: 0.1em; }
    .impresie { background: #EEE; color: navy; }
    a:hover { color: red; }
  </style>
</head>
<body>
<?php
  // exemplu de procesare SAX
  // autor: Sabin-Corneliu Buraga <busaco@infoiasi.ro> (c)2000-2001, 2007
  require("parseXML.php");

  // folosirea mostenirii pentru a defini
  // un alt comportament
  class parseXML2 extends parseXML {

    // indica daca exista atributul "email"
    var $is_email = 0;

    // redefinirea metodelor
    function start_element($parser, $name, $attrs) {
      // apeleaza metoda din clasa de baza
      parseXML::start_element($parser, $name, $attrs);
      // insereaza legatura spre adresa e-mail
      if (!strcmp($name, "nume")) {
         if ($attrs["email"]) {
           $format = "<a title=\"Trimite mesaj la " . $attrs["email"] .
                     "\" href=\"mailto:" . $attrs["email"] . "\">";
           $this->html_code .= $format;
           $this->is_email = 1;
         }
         else
           $this->is_email = 0;
      }
    }

    function end_element($parser, $name) {
      // &inchide </a>
      if (!strcmp($name, "nume")) {
        if ($this->is_email) {
          $format = "</a>";
          $this->html_code .= $format;
        }
      }
      // apeleaza metoda din clasa de baza
      parseXML::end_element($parser, $name);
    }
  }

  // substitutia elementelor XML cu cod HTML  
  $open_tags = array(
    "impresii" => '<table summary="impresii">',
    "impresie" => "<tr>",
    "nume" => "<td><h3>",
    "ocupatia" => "<td><p>",
    "virsta" => "<td><p><em>",
    "text" => '<td><p class="impresie">');
  $close_tags = array(
    "impresii" => "</table>\n" . 
       "<!-- sfirsitul generarii parseXML -->\n",
    "impresie" => "</tr>",
    "nume" => "</h3></td>",
    "ocupatia" => "</p></td>",
    "virsta" => "</em></p></td>",
    "text" => "</p></td>");

  // instantiaza si initializeaza analizorul    
  $parser = new parseXML2();
  $parser->set_xml_file("impresii.xml");
  $parser->set_open_tags($open_tags);
  $parser->set_close_tags($close_tags);
  // ruleaza analizorul
  $parser->parse();
  echo $parser->get_html_code();
  // distruge obiectul
  $parser->destroy();
?>
</body>
</html>
