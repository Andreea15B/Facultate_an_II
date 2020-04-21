<?php
/* Program PHP5 care defineste o clasa de manipulare a bazelor de date MySQL (MariaDB)
   pe baza unei clase abstracte
   
   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/ 
   2000, 2001, 2006, 2007, 2019
   
   Ultima actualizare: 6 martie 2019
*/   
abstract class DataBase_SQL { 		// clasa generica (abstracta)
	// date-membru 
	private $Link_ID; 	// identif. legaturii cu o baza de date 
	private $Query_ID; 	// identif. interogarii active 
	private $Errno; 		// starea de eroare 
	// metode (generice)
	abstract public function connect(); 		// conectare la serverul BD 
	abstract public function query($q); 		// trimiterea unei inter. SQL 
	abstract public function next_record(); // urmatoarea inreg. gasita	
	// eventual si altele...
}

class DataBase_MySQL extends DataBase_SQL { // clasa pentru MySQL  
	// date-membru
	private $Host; 			// adresa serverului MySQL 
	private $DataBase;	// numele bazei de date 
	private $User;			// numele utilizatorului  
	private $Password;	// parola utilizatorului 
	private $Row;				// numarul rândului curent 
	private $Error;			// mesajul de eroare 
	public  $Record = array(); // contine inregistrarile gasite
	
	// constructor
	public function __construct ($h = '', $db = '', $u = '', $p = '') {
	  $this->Link_ID = 0;
	  $this->Query_ID = 0;
	  $this->Errno = 0;
	  $this->Host = $h;
	  $this->DataBase = $db;
	  $this->User = $u;
	  $this->Password = $p;
	  $this->Row = -1;
	  $this->Error = '';
	}
	
	// destructor
	public function __destruct () {
	  if ($this->Link_ID) {
	    mysql_close ($this->Link_ID); // inchidem conexiunea
	  }  
	}
	
	// metode:
	// opreste executia în caz de eroare fatala 
	public function halt ($msg) { 
    printf("A survenit eroarea: %s\n", $msg); 
    printf("MySQL raporteaza: %s (%s)\n", $this->Errno, $this->Error); 
    die("Terminare anormala."); 
  } 
  
  // conectare la baza de date 
  public function connect () { 
    if ($this->Link_ID == 0) { // inca nu exista o conexiune 
      $this->Link_ID = mysql_connect (
         $this->Host, $this->User, $this->Password);       
      if (!$this->Link_ID) { // succes sau esec?
        $this->halt ("Conexiune esuata"); 
      }      
      // deschidem baza de date 
      if (!mysql_select_db($this->DataBase, $this->Link_ID)) {
        // salvam erorile 
        $this->Errno = mysql_errno(); 
        $this->Error = mysql_error(); 	
        $this->halt ("Baza de date " . $this->DataBase . 
           " nu poate fi deschisa");   
      } 
    } 
  }  

  // trimite o interogare serverului MySQL 
  public function query ($q) {   
    $this->connect(); // ne conectam... 
    // executam interogarea     
    $this->Query_ID = mysql_query ($q, $this->Link_ID);     
    // initial stabilim pointerul pe prima înregistrare 
    $this->Row = 0; 
    // salvam erorile 
    $this->Errno = mysql_errno(); 
    $this->Error = mysql_error();     
    if (!$this->Query_ID) { // eroare fatala?
    	$this->halt ("Comanda SQL eronata: " . $q); 
    }	
    return $this->Query_ID; 
  } 
  
  // furnizeaza daca mai exista o înregistrare 
  public function next_record() { 
  	// salvam într-un tablou înregistrarile 
  	$this->Record = mysql_fetch_array ($this->Query_ID); 
  	$this->Row++;
  	// salvam erorile 
  	$this->Errno = mysql_errno(); 
  	$this->Error = mysql_error(); 
  	// returnam inregistrarea gasita 
  	$stat = is_array ($this->Record); 
  	if (!$stat) { // nu mai exista o alta inregistrare 
  		mysql_free_result ($this->Query_ID); // se elibereaza interogarea 
  		$this->Query_ID = 0; 
    } 
    return $stat; 
  }
}  
?>