<?php
   // umplem un tablou cu valori de la 1 la 10
   for ($contor = 1; $contor <= 10; $contor++) {
     $valori[$contor] = $contor;
   }  
   // realizam suma valorilor
   $suma = 0;
   foreach ($valori as $element) 
     $suma += $element;
   // afisam suma obtinuta la iesirea standard 
   // pentru a fi trimisa clientului (browser-ului)  
   echo ("<p>Suma de la 1 la 10 este: <b>" . $suma . "</b></p>");
?>