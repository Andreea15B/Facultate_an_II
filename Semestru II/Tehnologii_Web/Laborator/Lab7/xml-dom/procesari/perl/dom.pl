#!/usr/bin/perl

# Script Perl care contorizeaza proiectele de clasa A
# Autor: Sabin-Corneliu Buraga
# Ultima actualizare: 30 decembrie 2004
use XML::DOM;

$parser = new XML::DOM::Parser;
$doc = $parser->parsefile ('projects.xml');

$proiecte = $doc->getElementsByTagName ('project');
$nr_proiecte = $proiecte->getLength;

$proiecte_clasaA = 0; # contorizeaza proiectele 'A'

# baleiam toate proiectele
for (my $i = 0; $i < $nr_proiecte; $i++) {
  $proiect = $proiecte->item ($i);
  # preluam clasa proiectului
  $clasa = $proiect->getAttributeNode ('class')->getValue;
  $proiecte_clasaA++ if $clasa eq 'A';
}

# afisam la iesirea standard
print "Pentru documentul XML de mai jos:\n";
print $doc->toString;
print "\nSunt $proiecte_clasaA proiecte de clasa A.\n";

# eliberam memoria
$doc->dispose();
