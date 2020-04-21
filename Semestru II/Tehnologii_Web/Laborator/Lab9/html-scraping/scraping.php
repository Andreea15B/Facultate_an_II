<?php
/* Program PHP ce exemplifica procesul de preluare de date (scraping)
   din documentele HTML

   Autor: Sabin-Corneliu Buraga -- https://profs.info.uaic.ro/~busaco

   Ultima actualizare: 05 aprilie 2019
*/    
require_once('simple_html_dom.php');

define('URL', 'https://www.nicherecords.ro/catalog/'); // URL-ul sitului oferind date

// caile spre produsele de interes (i.e. documentele HTML procesate)
$cai_produse = [ 
  "pop-rock/rock-psihedelic/pink-floyd-the-wall-dvd.html",
  "jazz/jazz-1/nina-simone-silk-soul-vinyl.html", 
  "clasica/clasica-1/bach-simply-bach-cd.html",
  "metal/heavy-metal/king-diamond-graveyard-vinyl-1.html"
];
foreach ($cai_produse as $cale) {
  $html = file_get_html(URL . $cale); // preluam date HTML despre fiecare produs

  // numele produsului (albumului muzical)
  $prod = $html->find("span.alb", 0)->plaintext;
  // codul de bare (pe sit e prefixat de "Cod produs: ", 
  // dar ne intereseaza doar cele 13 cifre de dupa ": ")
  $cod_bare = explode(": ", $html->find("span.barcode", 0)->plaintext)[1];
  // pretul (eliminam sirul " Lei" si convertim datele in numere intregi) 
  $pret = (int) explode(" ", $html->find("span.price", 0)->plaintext)[0];

  printf("<p><a title='Detalii' href='%s'>%s</a> &ndash; cod de bare: <code>%s</code>, preț: %d RON.</p>", URL . $cale, $prod, $cod_bare, $pret);
}
?>