<?php
    // exercitiul 2
    $suma = $_REQUEST["valoare"];
    $valutaInitiala = $_REQUEST["valutaFrom"];

    $url = 'https://api.exchangeratesapi.io/latest?base=' . $valutaInitiala;
    $ch = curl_init();

    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

    $output = curl_exec($ch);
    curl_close($ch);

    $results = json_decode($output);
    $valTo = $_REQUEST["valutaTo"];
    $valoareFinala = $results->rates->$valTo;

    $result = $suma * $valoareFinala;
    echo $suma . ' ' . $valutaInitiala . ' = ' . $result . ' ' . $valTo;
?>