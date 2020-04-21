
<?php
define ('WS_URL', 'http://localhost/php/server.php'); 

try {
	$client = new SoapClient(null,
	    [ 'location' => WS_URL,
        'uri'	     => 'http://web.info/profile',
        'trace'		 => 1 
		  ]
    );
    
  foreach (['Andreea', 'Maria'] as $profile) {
    $res = $client->__soapCall('getProfile', [ $profile ]);
    echo 'SOAP request:<pre class="cod">' . 
       htmlspecialchars($client->__getLastRequest(), ENT_QUOTES) . '</pre>';
    echo 'SOAP response:<pre class="cod">' . 
       htmlspecialchars($client->__getLastResponse(), ENT_QUOTES) . '</pre>';

    echo "<p>The profile of $profile is <strong>$res</strong>.</p>";
  }  
} catch (SOAPFault $exception) { // eroare :(
   echo 'An exception occurred: ' . $exception->faultstring;
}
?>