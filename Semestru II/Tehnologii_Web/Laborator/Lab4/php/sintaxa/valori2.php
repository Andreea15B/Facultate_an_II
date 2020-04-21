<?php
   // folosim o constanta specificand numarul maxim
   // de valori pentru care calculam suma
   define ('MAX', 20);
   
   // umplem un tablou cu valori de la 1 la MAX
   for ($contor = 1; $contor <= MAX; $contor++) {
     $valori[$contor] = $contor;
   }  
   // realizam suma valorilor
   $suma = 0;
   foreach ($valori as $element) 
     $suma += $element;
   // afisam suma obtinuta la iesirea standard 
   // pentru a fi trimisa browser-ului  
   echo ("<p>Suma de la 1 la " . MAX . " este: <em>" . $suma . "</em></p>");
?>   
