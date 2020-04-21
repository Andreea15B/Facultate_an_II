<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ro" xml:lang="ro">
<head>
<title>Un client SOAP</title>
<style type="text/css">
.cod { overflow: scroll; white-space: normal; }
</style>
</head>
<body>
<?php
/* Un program-client PHP5 utilizat la validarea documentelor XML, 
   invocand metode ale unui serviciu Web implementat sub .NET
   si folosind extensia SOAP

   Autor: Sabin-Corneliu Buraga - http://profs.info.uaic.ro/~busaco/
   Ultima actualizare: 24 noiembrie 2007
*/
$doc = $_REQUEST['xml'];
if (!$doc) 
  die ("Furnizati numele documentului via parametrul 'xml'.");
try {
   $client = new SoapClient('http://127.0.0.1:8080/xml-validator/xml-validator2.asmx?WSDL',
     array('trace' => 1));
   $rez = $client->CheckIfExists ($doc); 
   // apelarea explicita s-ar fi facut prin:
   // $rez = $client->__soapCall('CheckIfExists', array($doc));
   echo 'Cererea efectuata:<pre class="cod">' . 
     htmlspecialchars($client->__getLastRequest(), ENT_QUOTES) . '</pre>';
   echo 'Raspunsul obtinut:<pre class="cod">' . 
     htmlspecialchars($client->__getLastResponse(), ENT_QUOTES) . '</pre>';
   if ($rez == true) {
   	 $rez = $client->Validate ($doc);
   	 echo "<p>Documentul $doc este $rez.</p>";
   } else {
   	 echo "<p>Documentul $doc e inaccesibil (nu exista pe server?)</p>";
   }  
} catch (SOAPFault $exception) {
   echo 'A aparut o exceptie: ' . $exception->faultstring;
}
?>
</body>
</html>