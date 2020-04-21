<?php
/* Un server SOAP scris in PHP 5 oferind metode de manipulare a portocalelor

   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/
   Ultima actualizare: 30 aprilie 2011
*/
try {
  // nu oferim nici o descriere WSDL, stabilim URI-ul serviciului
  $server = new SoapServer(null, 
    array('uri' => 'urn:portocale.info') // spatiul de nume folosit
  );
  // adaugam metodele implementate
  $server->addFunction('furnizeazaCantit');
  // asteptam cereri SOAP
  $server->handle();   
} catch (SOAPFault $exception) {
  echo 'A aparut o exceptie: ' . $exception;
}

// functie care furnizeaza cantitatea dintr-un sortiment de portocale
// (rezultatul intors va fi eterogen)
function furnizeazaCantit ($numeSortiment) {
	// de obicei, aici vom efectua o interogare SQL, o procesare XML etc.
	switch ($numeSortiment) {
	 	 case 'japoneze': return 33;
	 	 case 'albastre': return 74;
	 	 default        : return 'inexistent';
	}
}
?>