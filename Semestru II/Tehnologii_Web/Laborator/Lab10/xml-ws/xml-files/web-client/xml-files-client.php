<?php
/* Program PHP5 care invoca o metoda a unui serviciu Web, 
   pentru a obtine lista de fisiere existente la distanta
   
   Autor: Sabin-Corneliu Buraga - http://profs.info.uaic.ro/~busaco/
   Ultima actualizare: 24 noiembrie 2007
*/
try {
   $client = new SoapClient(
     null,   // nu utilizam nici un document WSDL
     array ( // parametrii de invocare
       'location' => 'http://localhost:3333/xml-files.pl',
       'uri' => 'http://127.0.0.1:3333/XMLFiles/',       
       'trace' => 1));
   // invocam metoda de listare a fisierelor la nivel de server
   $rez = $client->__soapCall('List', array());
   // afisam lista de fisiere
   echo '<h3>Fisierele existente pe server</h3><ul>';
   // procesam raspunsul SOAP via Simple XML
   $xml = simplexml_load_string ($client->__getLastResponse());
   foreach ($xml->xpath("//file") as $file) {
     // afisam fiecare nume de fisier  
     echo '<li>' . $file['name'] . '</li>'; 
   }
   echo '</ul>';    
} catch (SOAPFault $exception) {
   echo 'A aparut o exceptie: ' . $exception->faultstring;
}
?>