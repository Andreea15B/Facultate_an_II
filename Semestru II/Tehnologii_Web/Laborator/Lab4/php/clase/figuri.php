<?php
/* Program PHP5 care ilustreaza definirea si folosirea de trasaturi (traits)
   disponibile incepand cu versiunea PHP 5.4.
   
   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/
   2014, 2017
    
   Ultima actualizare: 6 martie 2019
*/

trait Rotire {
  public function roteste ($unghi) {
    // ...
  }
}
 
trait Mutare {
  public function mutaLa ($x, $y) {
    // ...
  }
}

trait Colorare {
  public function coloreaza ($culoare) {
    // ...
  }
}

abstract class Figura {
  public function deseneaza() {
    echo ('Am desenat ' . get_class());
  }
}

class Dreptunghi extends Figura {
  use Colorare, Mutare, Rotire;
 
  public function transforma () {
    //...
  }
}

class Cerc extends Figura {
  use Mutare, Colorare;

  const PI = 3.1415265;

  public function calculeazaArie () {
    // ...
  } 
}

// instantierea unor obiecte
$unCerc = new Cerc();
$unDreptunghi = new Dreptunghi();
$unCerc->deseneaza();
$unDreptunghi->deseneaza();
?>