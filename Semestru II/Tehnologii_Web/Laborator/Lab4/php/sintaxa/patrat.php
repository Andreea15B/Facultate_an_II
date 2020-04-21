<?php
/* Un program PHP ce afiseaza patratele numerelor pare de la 1 la 10. */

function patrat($numar) { // functia de ridicare la patrat
  return $numar * $numar;
}

$numar = 0;

while ($numar < 10) {
  $numar++;       // incrementam numarul
  
  if ($numar % 2) // e numar impar...
    continue;     // continuam cu urmatoarea iteratie	
      
  // e numar par, deci afisam patratul    
  echo "<p>$numar la patrat este " . patrat($numar) . "</p>";  
}
?>    