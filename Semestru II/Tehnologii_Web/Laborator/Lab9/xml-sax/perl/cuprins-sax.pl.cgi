#!/usr/bin/perl

# Script CGI care afiseaza cuprinsul unei carti modelat in XML. 
# A se rula direct din navigator cu http://locatie/cale/cuprins.pl.cgi
# (necesita existenta modulului XML::Parser instalat in sistem). 
# Pentru mai multe detalii privitoare la procesarea SAX a se consulta
# 'Programare Web in bash si Perl' - http://profs.info.uaic.ro/~cgi/

# Autor: Sabin Corneliu Buraga (2002-2003, 2007)
# Ultima actualizare: 29 martie 2007
 
# utilizam modulul XML
use XML::Parser;

# definim tablourile hash de inlocuire a tag-urilor
# definim substitutiile de tag-uri de inceput
%start = (
"cuprins"    => '<table style="border: solid 1px black;width:600px" summary="Cuprinsul volumului">',
"capitol"    => '<tr>',
"nume"       => '<td><strong>',
"autor"      => '<td><p style="text-align: center">',
"descriere"  => '<td style="background: lightblue">'
);

# definim substitutiile de tag-uri de sfirsit
%sfirsit = (
"cuprins"    => "</table>\n",
"capitol"    => "</tr>\n",
"nume"       => "</strong></td>",
"autor"      => "</p></td>",
"descriere"  => "</td>"
);

# instantiem analizorul XML 
# (daca apare o eroare se va afisa contextul aparitiei - alte 2 linii de cod 
# continind linia care care a generat eroarea)
my $parser = new XML::Parser(ErrorContext => 2);
# setam functiile de prelucrare 
# a elementelor si continutului lor
$parser->setHandlers(
  Start => \&procesare_start, 
   # functia de procesare tag-uri de inceput
  End   => \&procesare_sfirsit,
   # functia de procesare tag-uri de sfirsit
  Char  => \&procesare_continut
   # functia de procesare a continutului
);

# trimitem antetul HTTP (tipul continutului)
print "Content-type: text/html\n\n";

# trimitem si corpul documentului
print << "HTML";
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Procesare SAX</title>
</head>
<body>
HTML

print '<h1>Lista capitolelor cartii</h1>';

# incarcam fisierul si il analizam
$parser->parsefile("cuprins.xml");

# trimitem finalul documentului
print << "HTML";
<hr />
</body>
</html>
HTML

# definim subrutinele pentru prelucrarea
# elementelor XML si continutului lor
sub procesare_start
{
  my $procesor = shift; 
  # primul argument este instanta procesorului XML
  my $element  = shift;
  # al doilea argument este numele elementului 
  # corespunzator tag-ului de inceput
  # nu ne intereseaza atributele, deci nu le preluam
    
  # afisam codul HTML, folosind tabloul hash
  print $start{$element};
}

sub procesare_sfirsit
{
  my $procesor = shift; 
  # primul argument este instanta procesorului XML
  my $element  = shift;
  # al doilea argument este numele elementului 
  # corespunzator tag-ului de sfirsit

  # afisam codul HTML, folosind tabloul hash
  print $sfirsit{$element};
}

# rutina de afisare a continutului
sub procesare_continut
{
  # am preluat argumentele furnizate
  my ($procesor, $data) = @_;

  # afisam datele
  print $data;
}