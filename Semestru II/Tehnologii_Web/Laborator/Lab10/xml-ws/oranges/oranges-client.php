<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ro">
<head>
<title>Portocale (exemplu de invocare via SOAP a unui serviciu Web)</title>
<style>
.cod { 
	overflow: scroll; 
	white-space: normal; 
	border: thin dotted gray;
	padding: 0.2em;
}
body {
  font-family: sans-serif;
}
</style>
</head>
<body>
<?php
/* Un client SOAP scris in PHP5 invocand operatii (metode) de obtinere 
   a stocului de portocale oferite de un serviciu Web

   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/
   Ultima actualizare: 22 aprilie 2019
*/

// de inlocuit cu URL-ul la care este operational serviciul Web
define ('WS_URL', 'http://localhost/php/oranges/oranges-server.php'); 

try {
	$client = new SoapClient(null,   // nu furnizam niciun WSDL 
	    [ 'location' => WS_URL, // adresa serviciului Web
        'uri'			 => 'http://web.info/porto', // spatiul de nume corespunzator serviciului Web apelat
        'trace'		 => 1 // se vor furniza informatii de depanare
		  ]
	);
  // realizam o suita de invocari ale metodei dorite
  foreach ([ 'blue', 'gray', 'celestial' ] as $product) {
    $res = $client->__soapCall('getQuantity', [ $product ]);
    // afisam si cererea si raspunsul SOAP incapsulate in documente XML 
    echo 'SOAP request:<pre class="cod">' . 
       htmlspecialchars($client->__getLastRequest(), ENT_QUOTES) . '</pre>';
    echo 'SOAP response:<pre class="cod">' . 
       htmlspecialchars($client->__getLastResponse(), ENT_QUOTES) . '</pre>';

    echo "<p>The quantity of $product oranges is <strong>$res</strong>.</p>";
  }  
} catch (SOAPFault $exception) { // eroare :(
   echo 'An exception occurred: ' . $exception->faultstring;
}
?>
</body>
</html>