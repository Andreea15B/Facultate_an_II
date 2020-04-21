<?php
/* Un client SOAP scris in PHP5 invocand operatii (metode) 
   expuse de un serviciu Web extern -- aici, un dictionar oferit la adresa
   http://services.aonaware.com/DictService/ (implementat in .NET)

   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/
   Ultima actualizare: 22 aprilie 2019
*/
// adresa Web a serviciului   
define ('WS_URL', 'http://services.aonaware.com/DictService/DictService.asmx');
// adresa Web a documentului WSDL descriind serviciul
define ('WS_WSDL', 'http://services.aonaware.com/DictService/DictService.asmx?WSDL');
// spatiul de nume al serviciului Web apelat
define ('WS_NS', 'http://services.aonaware.com/webservices/');

try {
	$client = new SoapClient(WS_WSDL, // folosim descrierea serviciului (WSDL) 
	  [ 'location' => WS_URL,         // adresa serviciului Web
      'uri'			 => WS_NS           // spatiul de nume corespunzator serviciului Web apelat
		]
  );
  /* invocăm metoda Define() a serviciului Web pentru a obține sensul unui termen dorit */
  $res = $client->Define ([ 'word' => 'knowledge' ]);
  
  /* preluăm prima definiție a termenului pe baza proprietăților generate automat asociate elementelor documentului XML încapsulat în plicul SOAP al răspunsului furnizat */
  echo "<pre><strong>Definition</strong>:\n" . 
    $res->DefineResult->Definitions->Definition[0]->WordDefinition . "\n</pre>";

} catch (SOAPFault $exception) { // eroare :(
  echo 'An exception occurred: ' . $exception->faultstring;
}
