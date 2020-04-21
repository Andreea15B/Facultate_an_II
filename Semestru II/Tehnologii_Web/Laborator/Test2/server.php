<?php
$mysql = new mysqli (
	'localhost',
	'root',
	'',
	'profiles'
  );
  
  if (mysqli_connect_errno()) {
    die ('Conexiunea a esuat...');
  }

try {
    $server = new SoapServer(null, 
      array('uri' => 'http://web.info/profile') 
    );
    $server->addFunction('getProfile');
    $server->handle();   
  } catch (SOAPFault $exception) {
    echo 'An exception occurred: ' . $exception;
  }

function getProfile ($profile) {
  if (!($rez = $mysql->query ('select name from profiles'))) {
    die ('A survenit o eroare la interogare');
  }
	return $rez;
}
?>