#!/usr/bin/perl -w
# Program ce implementeaza un server SOAP oferind un serviciu Web 
# de manipulare a fisierelor - se utilizeaza modulul SOAP::Lite
# Autor: Sabin-Corneliu Buraga - http://profs.info.uaic.ro/~busaco/
# Ultima actualizare: 07 august 2006

use strict;
use SOAP::Transport::HTTP +debug => [qw(all)];
# nu dorim sa fim intrerupti la semnale precum 'Broken pipe' ori 
# la actionarea combinatiei de taste CTRL+C
$SIG{PIPE} = $SIG{INT} = 'IGNORE';

# initializam serverul, folosind un daemon HTTP 
my $server = SOAP::Transport::HTTP::Daemon->new (
    LocalAddr => 'localhost', # adresa locala
    LocalPort => 3333,        # portul utilizat
    Reuse     => 1);          # se reutilizeaza imediat portul
# functionalitatea serverului e preluata de clasa 'XMLFiles'
$server->dispatch_to ('XMLFiles');

print 'Serverul SOAP ruleaza la ' . $server->url;
# ne blocam, asteptind cereri din partea clientilor
$server->handle;

BEGIN { # clasa implementind functionalitatile serviciului Web
  package XMLFiles;
  use SOAP::Lite;
  use base qw(SOAP::Server::Parameters); 
    
  sub List { # metoda de generare a listei fisierelor existente
    my $self = shift;
    my $envelope = pop;
    my $files = '';
    # returnam raspunsul ca fiind un fragment de document XML
    foreach my $file (glob('*')) {
      $files .= "<file name=\"$file\" />";
    }  
    return SOAP::Data->type('xml' => $files);
  }
  
  sub CheckIfExists { # metoda de verificare a existentei unui fisier
    my $self = shift;
    my $envelope = pop;
    # preluam parametrul de intrare via o expresie XPath
    # (nu stim cum ar putea fi incapsulat)
    my $filename = $envelope->dataof('//filename');
    # trimitem un 'fault' daca nu exista parametrul de intrare
    die SOAP::Fault->faultcode('Server.CheckIfExists')
                   ->faultstring('Input parameter is missing')
      unless $filename; 
    # furnizam daca exista fisierul in cauza  
    return (-e $filename->value) ? 1 : 0;    
  }
  
  sub Rename { # metoda de redenumire a unui fisier
    my $self = shift;
    my $envelope = pop;
    # preluam parametrii de intrare
    my $filename = $envelope->dataof('//filename');
    my $newname  = $envelope->dataof('//newname');
    # eventual, semnalam inexistenta lor
    die SOAP::Fault->faultcode('Server.Rename')
                   ->faultstring('Input filename parameter is missing')
      unless $filename;
    die SOAP::Fault->faultcode('Server.Rename')
                   ->faultstring('Input newname parameter is missing')
      unless $newname;  
    # returnam raspunsul   
    return SOAP::Data->name('result' =>
      (rename ($filename->value, $newname->value) ? 'success' : 'error'));
  }  
  # eventual, alte metode...
}    