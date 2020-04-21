<?php
/* Program PHP ce ilustreaza filtrarea unor valori dintr-un tablou
   pe baza unei functii specificate de programator
   
   Ultima actualizare: 06 martie 2016
*/
function valoare_mai_mica_decat ($numar)
{
	// intoarce o expresie de tip functie (abordare functionala)
    return function($element) use ($numar) {
        return $element < $numar;
    };
}

$punctaje = array (7, 8, 9, 10, 5, 3, 10, 6, 4);

// folosim functia predefinita array_filter() asupra tabloului cu punctaje
// pentru a obtine valorile mai mici decat o valoare data (aici: 7)
$valori = array_filter ($punctaje, valoare_mai_mica_decat (7));

print_r ($valori);
?>