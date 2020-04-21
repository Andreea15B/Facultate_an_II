<?php 
/* Program PHP care exemplifica folosirea cookie-urilor pentru a retine 
   culoarea de fundal preferata de un utilizator

   Autor: Sabin-Corneliu Buraga - https://profs.info.uaic.ro/~busaco/
   
   Ultima actualizare: 6 martie 2018
*/   
   define ('CULOARE_IMPLICITA', 'white');
   
   // verificam daca exista culoarea
   $culoare = $_REQUEST['culoare'];

   if (!$culoare) { // nu exista
   	 $culoare = CULOARE_IMPLICITA; // stabilim culoarea implicita
   }	 
   // setam cookie-ul sa expire peste 10 zile
   if (!setcookie('culoare_fundal', $culoare, time() + 60 * 60 * 24 * 10)) {
   	  echo 'Cookie-ul n-a putut fi creat.';
   }   
?> 
<!DOCTYPE html>
<html>
	<head>
		 <title>Culori preferate</title>
		 <style>
		 body { background: <?php echo $_COOKIE['culoare_fundal']; ?> }
		 </style>
	</head>
	<body>
		<p>Alegeti culoarea de fundal preferata 
			 ce va aparea la urmatoarea vizita:</p>
	    <!-- date transmise prin metoda POST -->
		<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="post">
		   <select name="culoare">
		  	<?php
		  	   // generam lista de culori
		  	   foreach (
		  	     array('cyan', 'yellow', 'white', 'pink', 'lightblue') as $c) {
		  	   	  echo '<option value="' . $c . '">' . $c . '</option>';
		  	   }
		  	?>
		   </select>
		   <input type="submit" value="Alege culoarea" />
		</form>
	</body>
</html>