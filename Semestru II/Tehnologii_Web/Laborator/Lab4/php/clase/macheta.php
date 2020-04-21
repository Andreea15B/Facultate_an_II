<?php
/* Program PHP5 care exemplifica specificarea de interfete
   Detalii in prelegerea disponibila la adresa Web
   https://profs.info.uaic.ro/~busaco/teach/courses/web/web-film.html#week5
   
   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/
   2014, 2017, 2019
    
   Ultima actualizare: 6 martie 2019
*/

// interfata privind o macheta de vizualizare (template)
interface iMacheta {
    // seteaza o variabila ce va fi substituita
    public function setVar ($nume, $var);
    // furnizeaza reprezentarea machetei
    public function oferaReprez ($macheta);
}

// clasa implementand interfata
class Macheta implements iMacheta {
	// tablou cu variabilele ce trebuie substituite
    private $variabile = array();
  
    public function setVar ($nume, $var) {
        $this->variabile[$nume] = $var;
    }
  
    public function oferaReprez ($macheta) {
        foreach($this->variabile as $nume => $val) {
        	// substituim numele variabilelor cu valorile lor in macheta
            $macheta = str_replace('{' . $nume . '}', $val, $macheta);
        }
 
        return $macheta;
    }
}
?>