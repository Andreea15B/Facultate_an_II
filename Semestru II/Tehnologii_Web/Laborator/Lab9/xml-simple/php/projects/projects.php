<?php
   // Program PHP5 care proceseaza un document XML prin intermediul
   // interfetei simplificate SimpleXML
   // Autor: Sabin-Corneliu Buraga (2006, 2010, 2017)
   
   // incarcam documentul XML (tema: tratarea erorilor/exceptiilor)
   $xml = simplexml_load_file('http://localhost/projects.xml'); // ar putea fi folosit un URL real
   
   // afisam descrierile proiectelor de clasa S
   foreach ($xml->project as $proiecte) {
   	 if ($proiecte['class'] == 'S')
   	   echo '<p>' . $proiecte->desc . '</p>';
   }	
   // similar, dar utilizand o expresie XPath
   foreach ($xml->xpath("//project[@class='S']") as $proiecte) {
   	 echo '<p>' . $proiecte->desc . '</p>';
   }
?>