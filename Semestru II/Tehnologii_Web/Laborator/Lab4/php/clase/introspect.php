<?php
/* Program PHP5 care exemplifica specificarea de clase derivate, 
   constructori si destructori, modificatori de acces si folosirea introspectiei
   
   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/
   2003, 2007-2009, 2011, 2019
    
   Ultima actualizare: 6 martie 2019
*/

// definim o constanta
define("AN_IMPLICIT", 2);

class Student { // clasa privitoare la un student

  // date-membru (private/publice)
  private $an;		// anul de studii (privat)
  public  $nume;	// numele
  public $email;	// adresa de e-mail
    
  // constructor (in stilul nou din PHP5)
  function __construct ($a = AN_IMPLICIT, $n = '', $e = '') {
    $this->an = $a;
    $this->nume = $n;
    $this->email = $e;
  }
  
  // destructor
  function __destruct () {
    print '<p>L-am distrus pe ' . $this->nume . '!</p>';
  }
  
  // metode
  function seteazaAn ($un_an) {
    $this->an = $un_an;
  }
  function furnizeazaAn () {
    return $this->an;
  }

  // eventual si alte metode...
}

class StudentDestept extends Student {
  // date-membru suplimentare (protejate)
  protected $note;
  
  // constructor (in stilul nou)
  function __construct ($a = AN_IMPLICIT, $n = '', $e = '', $note = NULL) {
    // apelam constructorul clasei de baza
    parent::__construct ($a, $n, $e);
    $this->note = $note;
  }
  
  // metode
  function seteazaNote ($niste_note) {
    $this->note = (array) $niste_note;	
  }
  function furnizeazaNote () {
    return (array) $this->note;
  }
}      
   
// instantierea unui obiect al clasei Student
// ultimul argument va avea valoarea implicita
$stud = new Student (3, "Vlad Manea", "vm@undeva.ro");
// utilizarea datelor membre si a metodelor clasei
$nume = $stud->nume; 
echo ("<p>Anul de studii al lui <strong>$nume</strong> este " .
      $stud->furnizeazaAn () . ".</p>");
if (!$stud->email) {
  echo ("<p>Adresa de e-mail nu a fost setata.</p>");
}

// stabilim o serie de note pentru un student destept
$note = array ("Web" => 10, "IP" => 10, "Java" => 9); // speculatii :)

$altStudent = new StudentDestept (2, "Bogdan Duduman", "dudu@undeva.ro");
$altStudent->seteazaNote ($note);

$alteNote = $altStudent->furnizeazaNote ();

if ($note === $alteNote) {
  echo ("<p>Notele au ramas aceleasi...<br />");
  echo ("La 'Tehnologii Web', $altStudent->nume a luat <em>" . 
        $alteNote["Web"] . "</em>.</p>");
}  
else  	
  echo ("<p>Notele s-au schimbat!?</p>");
  
// folosim introspectia
// cream o instanta a clasei predefinite ReflectionClass
$clasa = new ReflectionClass ('StudentDestept');
// afisam informatii despre clasa specificata
printf ("<p>Clasa <em>%s</em> extinde %s și e declarată în fișierul <tt>%s</tt>.</p>",
  $clasa->getName (), var_export ($clasa->getParentClass (), 1),
  $clasa->getFileName ());
?>