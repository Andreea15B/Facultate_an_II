// Un mini-robot Web scris in JavaScript pentru Node.js
// care afiseaza toate URL-urile relative dintr-un document preluat de pe un sit Web
// adaptare dupa M. Takada (2012)
var http  = require ('http');
var qs    = require ('querystring');
var dom   = require ('xmldom').DOMParser;

// dorim sa obtinem reprezentarea corespunzatoare resursei
// de la http://www.google.ro/search?q=web+programming+node.js
var cerere = http.get("http://www.google.ro/search?" + qs.stringify({ q: 'web programming node.js' }), function(raspuns) {
  // procesam raspunsul (poate sosi in fragmente de date)
  var rezultat = '';
  // tratam evenimentul privitor la aparitia datelor
  raspuns.on ('data', function(date) {
    rezultat += date;
  });
  // tratam evenimentul de finalizare a transferului
  raspuns.on ('end', function() {

	console.log (procesareHTML (rezultat));	
  });
});
// atasam o functie de tratare a erorilor
cerere.on ('error', function(e) {
  console.log ("A aparut o eroare: " + e.message);
});

// realizeaza procesarea dorita (Web scraping)
// cauzeaza redarea unor avertismente, deoarece codul HTML nu e bine formatat
function procesareHTML (document) {
  var adrese = [];
  
  // instantiem un procesor DOM
  try {
    var doc = new dom().parseFromString(document, "text/html");
    // preluam toate elementele <a>
    var noduri = doc.getElementsByTagName('a');
    // obtinem valoarea atributului 'href' (URL-ul)
    for (var i = 0; i < noduri.length; i++) {
      // plasam in tablou doar daca e relativ si e prefixat de "/url?q="
      var uri = noduri[i].getAttribute('href');
      if (!uri.match(/^http(s?)/gi) && uri.match(/^\/url\?q=/g)) {
        adrese.push (uri);
      }
    }
  } catch (e) { 
  	console.log (e.message); 
  }
  return (adrese);
}