<?php
/* Script PHP utilizat pentru efectuarea transformarilor XSLT
   Functioneaza pentru PHP versiunea 5.x
   
   Autor: Sabin-Corneliu Buraga (2002, 2004, 2007)
   Ultima actualizare: 30 octombrie 2007
*/   
define ('PATH', ''); // locul unde sunt stocate fisierele

// Initializam si rulam procesul XSLT
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

// 'pag' este un parametru de intrare reprezentind pagina care va fi generata 
// (se poate furniza in query_string sau via un formular Web)
$pag = $_REQUEST['pag']; 
// verificam existenta fisierelor

if (!is_file ($pag . '.xml') || !is_file ($pag . '.xsl')) {
  echo ("<p>Un fi&#351;ier XML/XSL lipse&#351;te.\n 
    Probabil scriptul a fost apelat &icirc;n mod eronat.</p>");
} 
else  
  if (!xslt_transf($pag . '.xml', $pag . '.xsl')) { // eroare
    echo ("<p>Int&acirc;mpin&#259;m o serie de probleme tehnice.</p>");
  }  	 
?>