<?php
/* Program PHP7 ce ilustreaza verificarea stricta a tipurilor de date
   pentru argumentele de intrare si valoarea intoarsa de o functie 
   ce aduna un numar variabil de numere intregi

   Ultima actualizare: 06 martie 2016
*/
declare (strict_types=1);

function aduna(int ...$numere):int {
    $suma = 0;
    foreach ($numere as $numar) {
        $suma += $numar;
    }
    return $suma;
}

echo aduna (7, 3, 74, 1);
echo aduna (pi (), '?');
?>