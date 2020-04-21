<!DOCTYPE html>
<html>
<head>
	<title>Stiri preluate dintr-un document Atom</title>
</head>
<body>
<?php
   // Program PHP 5 care foloseste procesarea XML simplificata 
   // pentru a afisa intrarile dintr-un document Atom generat de Blogger.com
   
   // Autor: Sabin-Corneliu Buraga - http://www.purl.org/net/busaco   
   // Ultima actualizare: 16 aprilie 2013
   
   // incarcam documentul XML 
   $xml = @simplexml_load_file('http://localhost/sxml/atom.xml'); // poate fi folosit un URI real   
   
   echo '<header><h1>Insemnarile de pe <em>blog</em>-ul lui ' . 
     $xml->author->name . '</h1></header>';
   echo '<article><ol>';
   // baleiam insemnarile (elementele <entry>)
   foreach ($xml->entry as $insemnare) {
   	 echo '<li><a title="Detalii" href="' . 
   	   $insemnare->link['href'] . '">' . 
   	   htmlspecialchars($insemnare->title) . '</a>';
   	 // daca avem <content type="html">...</content>,
   	 // atunci afisam continutul (este un fragment HTML)
   	 if ($insemnare->content['type'] == 'html') {
   	   echo '<section class="news">' . $insemnare->content . '</section>';
   	 }
   	 echo '</li>';
   }
   echo '</ol></article>';
?>
</body>
</html>