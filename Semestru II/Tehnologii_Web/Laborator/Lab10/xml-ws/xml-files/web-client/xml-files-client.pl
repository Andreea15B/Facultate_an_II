#!/usr/bin/perl -w
# Program client de invocare a unui serviciu Web privitor la operatii cu fisiere
# Autor: Sabin-Corneliu Buraga - http://profs.info.uaic.ro/~busaco/
# Ultima actualizare: 07 august 2006

# folosim modulul SOAP::Lite 
use SOAP::Lite; 
# pentru depanare/trasare, a se utiliza:
# use SOAP::Lite +debug => [qw(all)]; 

if (scalar(@ARGV) < 1) {
  print "Client de accesare a metodelor oferite de un serviciu Web\npentru accesarea sistemului de fisiere de pe server.\n";
  print "Sintaxa: $0 <fisier_existent_pe_server>\n";
  exit(1);
}
      
# ne conectam la server
my $soap = SOAP::Lite
             ->uri('http://127.0.0.1:3333/XMLFiles/') 
                  # adresa spatiului de nume
             ->proxy('http://127.0.0.1:3333/XMLFiles/xml-files.pl'); 
                  # locatia serviciului

# impachetam explicit parametrii, folosind nume calificate
# pentru parametrii metodei invocate
my @params = (SOAP::Data->name('filename', $ARGV[0]));

# verificam daca fisierul exista pe server
$response = $soap->call('CheckIfExists' => @params);

# verificam daca a aparut o eroare (SOAP fault)
if ($response->fault) {
  die 'A aparut o eroare: ' . $response->faultstring;
}

# daca rezultatul primit e nul, fisierul nu exista
if (!$response->result) {
  die 'Fisier inaccesibil (nu exista pe server?)';
}  else {
  print "Fisierul exista.\n";
}

# invocam metoda de redenumire a fisierului
# adaugind si numele cel nou al acestuia
push (@params, SOAP::Data->name('newname', $ARGV[0] . '.renamed')); 
if ($soap->call('Rename' => @params)->result eq 'success') {
  print "Redenumire realizata cu succes.\n";  
}
# afisam fisierele existente pe server
print "Fisierele existente pe server:\n";
# lista fisierelor existente (toate valorile atributului 'name')
$result = $soap->call('List');
foreach my $file ($result->dataof('//file')) {
  print $file->attr->{'name'} . "\n";
}