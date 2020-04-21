<?php
/* Program PHP5 care exemplifica specificarea de clase derivate, 
   constructori si destructori, plus modificatori de acces.
   
   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/
   2003, 2007-2009, 2011, 2015, 2017, 2019
    
   Ultima actualizare: 6 martie 2019
*/
class Student { // specificarea unei clase
  // proprietati (date-membre)
  private $an;       
  public $nume;        
  private $email;      
  // metode publice
  public function seteazaAn ($unAn) { 
     $this->an = $unAn; 
  }
  public function furnizeazaAn () { 
     return $this->an; 
  }
}

// Un student destept e tot un student... ;)
class StudentDestept extends Student {
    private $note;    // notele obținute (proprietate)
    
    // noi metode publice
    public function seteazaNote ($n) { 
        $this->note = (array) $n; 
    } 
    public function furnizeazaNote () { 
        return (array) $this->note; 
    }
}

$stud = new Student (); // instantierea unui obiect 
$stud->seteazaAn (2);
$stud->nume = 'Tux';

$altStud = new StudentDestept ();
// apel de metoda din clasa de baza
$altStud->seteazaAn (2); 
// apel de metoda din clasa derivata
$altStud->seteazaNote ( ['TW' => 10, 'IP' => 9] ); 

print_r ($altStud); // afisam datele despre structura interna a variabilei
?>