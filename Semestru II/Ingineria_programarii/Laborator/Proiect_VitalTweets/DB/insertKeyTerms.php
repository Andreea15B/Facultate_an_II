
<html>
	<p>Pentru a fi procesat fisierul va avea termenii 
		delimitati de \n adica newLine.</p>
	<p> Altfel spus termenii nu sunt separati prin 
		virgula ci printr-un "enter".</p>
	<form action="insertKeyTerms.php" method="POST" 
		enctype="multipart/form-data">
		
		<br>
		
		<label>Server name: </label>
		<input name="server_name" type="text"/>
		<br>
		<label>Username: </label>
		<input name="username" type="text"/>
		<br>
		<label>Database  name: </label>
		<input name="database_name" type="text"/>
		<br>
		<label>Parola: </label>
		<input name="password" type="password"/>
		<br>
		<input type="file" name="keyTermsFile" 
			id="keyTermsFile" />
		<br><br>
		<button type="submit">Connect to database</button>
		<br><br>
	</form>
</html>

<?php
  	
//error_reporting(0);	

/*if( !empty($_POST['password']) && 
	isset($_POST['password']) ){
	if($_POST['password']=="oParolaAntiSpam") {*/
	
		if( !empty($_FILES['keyTermsFile']['tmp_name']) && 
			isset($_FILES['keyTermsFile']['tmp_name']) ){
				
			$fileContentString = 
				file_get_contents($_FILES['keyTermsFile']['tmp_name']);

		 	$keyTerms = file($_FILES['keyTermsFile']['tmp_name']);
		
			if(isset($_POST['server_name'])){
				$servername=$_POST['server_name']; 
			}
			if(isset($_POST['username'])){
				$username=$_POST['username'];
			}
			
			if(isset($_POST['database_name'])){
				$dbname=$_POST['database_name'];
			}
			if(isset($_POST['password'])){
				$password=$_POST['password'];
			}
			
			if(!file_exists("atempts.txt")){
				$atemptsFile = fopen("atempts.txt","w");
				$attempts = fputs($atemptsFile,0);
				fclose($atemptsFile);
			}
			
			
			$maxAtempts = 100; 
			$atemptsFile = fopen("atempts.txt","r");
			$attempts = fgets($atemptsFile);
			fclose($atemptsFile);
			
		
			$conn = new mysqli($servername, $username, $password, $dbname);
			
			if (mysqli_connect_errno()) {
				
				if($attempts == $maxAtempts) {
					echo("Server blocked for security! Contact the administrator.");
				}
				else {
					$attempts++;
					$atemptsFile = 
						fopen("atempts.txt","w");
					fputs($atemptsFile,$attempts);
					fclose($atemptsFile);
					
					echo("Wrong authentication or server down!");
				}
			
			}
			else{
				
				if($attempts == $maxAtempts) {
					echo("Server blocked for security! Contact the administrator.");
				}else{

					$sql = "INSERT INTO KeyTerms values ";
					
					foreach($keyTerms as $term){
						
						$trimedTerm = trim($term," \r\n");
						
						$sql = 
							$sql."(".
								mysqli_real_escape_string($conn, "NULL").",".
								"'".mysqli_real_escape_string($conn, $trimedTerm)."',".
								"'".mysqli_real_escape_string($conn, "engleza")."',".
								"'".mysqli_real_escape_string($conn, "germana")."',".
								"'".mysqli_real_escape_string($conn, "franceza")."',".
								"'".mysqli_real_escape_string($conn, "spaniola")."'".
								"),";

					}
					$sql[strlen($sql)-1] = ";";
					echo($sql);
					
					/*$result = mysqli_multi_query($conn, $sql);
					if($result){echo("Operatia s-a efectuat cu succes!");}
					*/mysqli_close($conn);
				}
			}

		}
		else {
			if(isset($_FILES['keyTermsFile']['tmp_name']))
				echo("Nu ati introdus un fisier sau serverul
						nu a acceptat fisierul!");
		}
		
	/*}
	else {
		echo("Parola incorecta!");
	}
	
} else{
	if(isset($_POST['password']))
			echo("Nu ati introdus o parola!");
}*/
?>