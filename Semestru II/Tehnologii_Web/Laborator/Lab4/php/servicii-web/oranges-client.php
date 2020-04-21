<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ro" xml:lang="ro">
<head>
<title>Portocale</title>
</head>
<body>
<?php
/* Un client SOAP scris in PHP 5 invocind metode de obtinere 
   a stocului de portocale

   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/
   Ultima actualizare: 6 martie 2019
*/
try {
	$client = new SoapClient(null, 
	    array('location' => 'http://localhost/sxml/oranges-server.php', // adresa serviciului
              'uri'      => 'urn:portocale.info'                        // spatiul de nume
		)
	);
   // realizam o suita de invocari ale metodei dorite
   foreach (array('albastre', 'japoneze', 'celeste') as $sortiment) {
     $rez = $client->__soapCall('furnizeazaCantit', array($sortiment));
     echo "<p>Stocul de portocale $sortiment este <strong>$rez</strong>.</p>";
   }  
} catch (SOAPFault $exception) {
   echo 'A aparut o exceptie: ' . $exception->faultstring;
}
?>
</body>
</html>