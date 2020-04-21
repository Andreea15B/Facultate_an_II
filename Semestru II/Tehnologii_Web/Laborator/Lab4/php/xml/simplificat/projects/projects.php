<?php
   // Program PHP5 care proceseaza un document XML prin intermediul
   // interfetei simplificate SimpleXML
   // Autor: Sabin-Corneliu Buraga (2006, 2010)
   
   // incarcam documentul XML (tema: tratarea erorilor/exceptiilor)
   $xml = simplexml_load_file('http://localhost/sxml/projects.xml'); // ar putea fi folosit un URL real
   
   // afisam descrierile proiectelor de clasa A
   foreach ($xml->project as $proiecte) {
   	 if ($proiecte['class'] == 'A')
   	   echo '<p>' . $proiecte->desc . '</p>';
   }	
   // similar, dar utilizand o expresie XPath
   foreach ($xml->xpath("//project[@class='A']") as $proiecte) {
   	 echo '<p>' . $proiecte->desc . '</p>';
   }
?>