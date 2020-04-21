<?php
/* Script PHP utilizat pentru generat stiri despre punctaje, 
   prin efectuarea unei transformari XSLT
   Functioneaza pentru PHP versiunea 5.x
   
   Autor: Sabin-Corneliu Buraga (2007, 2008) -- http://www.purl.org/net/busaco
   Ultima actualizare: 03 mai 2008
*/   
define ("PATH", ''); // locul unde sunt stocate fisierele
define ("XML", 'punctaje.xml');
define ("XSL", 'punctaje.xsl');

/* Initializam si rulam procesul XSLT */
function xslt_transf($xml, $xsl) {
  try {
    // incarcam documentul XML
    $doc = new DomDocument;
    $doc->load (PATH . $xml);
    // incarcam foaia XSLT
    $transf = new DomDocument;
    $transf->load (PATH . $xsl);

    // folosim procesorul XSLT
    $proc = new xsltprocessor;
    $proc->importStyleSheet($transf); // atasam foaia de stiluri
    echo $proc->transformToXML($doc); // afisam rezultatul transformarii
  }
  catch (Exception $e) {
  	return FALSE; // a aparut o exceptie
  }
  return TRUE;
}


// verificam existenta fisierelor
if (!is_file (PATH . XML) || !is_file (PATH . XSL)) {
  die ('Un fisier XML/XSL lipseste.');
} 
if (!xslt_transf(XML, XSL)) { // eroare
  die ('Generarea de stiri RSS nu s-a putut efectua.');
}  	 
?>