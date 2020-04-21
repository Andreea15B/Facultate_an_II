<?php
/* Program PHP care invoca serviciul Web de
   prescurtare de URL-uri oferit de http://is.gd/

   Folosim libcurl (cURL) pentru a obtine reprezentarea XML
   a raspunsului oferit de serviciu.
   Documentul XML rezultat va avea forma generala:
   <output><shorturl>URL</shorturl></output>.

   Alte detalii sunt furnizate la https://is.gd/developers.php

   Tema: de tratat posibilele exceptii.

   Autor: Sabin-Corneliu Buraga (2012, 2014, 2016, 2017) -- https://profs.info.uaic.ro/~busaco/
   Ultima actualizare: 14 mai 2018
*/

define ('URL', 'https://is.gd/create.php?format=xml&url=profs.info.uaic.ro/~busaco');

echo '<p>Invoking Web service from <code>' . URL . '</code></p>';

$c = curl_init ();
curl_setopt ($c, CURLOPT_URL, URL);              // stabilim URL-ul serviciului
curl_setopt ($c, CURLOPT_RETURNTRANSFER, true);  // rezultatul cererii va fi disponibil ca șir de caractere
curl_setopt ($c, CURLOPT_SSL_VERIFYPEER, false); // nu verificam certificatul digital
$res = curl_exec ($c);                           // executam cererea GET
curl_close ($c);

echo '<p>Server response:</p>';
echo '<code>' . $res . '</code>';

// procesam rezultatul via DOM
$doc = new DOMDocument ();
$doc->loadXML ($res);

// preluam continutul elementului <shorturl>
$urls = $doc->getElementsByTagName ('shorturl');
   echo '<p>New short URL is <a href="' .
      $urls->nodeValue . '">' . $urls->nodeValue . '</a></p>';

?>