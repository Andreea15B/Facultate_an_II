<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<title>InfoQ News &amp; Resources</title>
<link rel="stylesheet" type="text/css" href="//profs.info.uaic.ro/~busaco/teach/courses/web/web.css" />
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<style type="text/css">
body {
	width: 100%;
}
img {
	width: 50%;
	height: 50%;
}
.news {
	padding: 0.3em;
	margin: 0;
	float: left;
	width: 23%;
}
</style>
</head> 
<body>
<header>
<h1>InfoQ News</a></h1>
<p class="slogan">resources of interest regarding software development</p>
</header>
<article>
<?php
/* Program PHP ce preia datele oferite de un flux RSS (document XML),
   pe baza unei expresii XPath.
*/   
define ('FEED', 'infoq.rss'); // adresa fluxului de știri RSS
define ('XPATH', '/rss/channel/item');         // expresia XPath utilizată

// funcție ce generează o legatură HTML spre resursă, oferind inclusiv descrierea ei
function genLink ($url, $newsTitle, $pubDate = '', $desc = '') {
  return "<section class='news'><p><a href=\"$url\" title=\"$newsTitle\">$newsTitle</a> ($pubDate)</p><div>" .
    $desc . "</div></section>";
}

try {
  // încărcăm documentul XML pe baza URL-ului furnizat
  $xml = simplexml_load_file (FEED);
  // baleiăm însemnările (aici, elementele <item> din RSS) 
  foreach ($xml->xpath (XPATH) as $news) {
  	 echo genLink ($news->link, $news->title, $news->pubDate, $news->description);
  }
}
catch (RuntimeException $e) { 
    echo $e->getMessage();                  // a survenit o excepție
}
?>
</article>
</body>
</html>