<?php
/* Program PHP care invoca serviciul Web de
   prescurtare de URL-uri oferit de http://is.gd/

   Folosim cURL pentru a obtine reprezentarea XML
   a raspunsului oferit de serviciu.
   Documentul XML rezultat va avea forma generala:
   <output><shorturl>URL</shorturl></output>.

   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/ 
   Ultima actualizare: 19 mai 2012
*/

// URL-ul serviciului Web invocat, inclusiv datele de intrare
// (aici, adresa Web ce va fi prescurtata)
define('URL', 'http://is.gd/create.php?format=xml&url=profs.info.uaic.ro/~busaco');

echo '<p>Invocam serviciul Web de la <code>' . URL . '</code></p>';

// initializam cURL
$c = curl_init();

// stabilim URL-ul serviciului Web invocat
curl_setopt($c, CURLOPT_URL, URL);

// rezultatul cererii va fi disponibil ca sir de caractere
// intors de apelul curl_exec()
curl_setopt($c, CURLOPT_RETURNTRANSFER, 1);

// preluam resursa oferita de server (aici, un document XML)
$res = curl_exec($c);

// inchidem conexiunea cURL
curl_close($c);

echo '<p>Raspunsul oferit de serviciu:</p>';
echo '<pre>' . htmlentities($res) . '</pre>';

// procesam rezultatul via DOM
$doc = new DOMDocument();
$doc->loadXML($res);

// preluam continutul elementului <shorturl>
$urls = $doc->getElementsByTagName ('shorturl');
foreach ($urls as $url) {
   echo '<p>Adresa prescurtata este: <a href="' .
      $url->nodeValue . '">' . $url->nodeValue . '</a></p>';
}
?>