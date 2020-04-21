#!/usr/bin/perl

# Script CGI utilizat pentru realizarea de transformari XSLT
# Autor: Sabin-Corneliu Buraga (2004, 2005)
# Ultima actualizare: 18 octombrie 2005

use XML::XSLT;
use CGI;

# preluam numele documentului (fara extensie) 
$doc = CGI::param('doc') 
  or die('Lipseste numele documentului.');

# initializam procesorul XSLT (dorim sa fie raportate si avertismentele)
my $xslt = XML::XSLT->new ($doc . '.xsl', warnings => 1);

$xslt->transform ($doc . '.xml');

# afisam rezultatul transformarii        
print CGI::header();
print $xslt->toString;

# eliberam memoria
$xslt->dispose();
