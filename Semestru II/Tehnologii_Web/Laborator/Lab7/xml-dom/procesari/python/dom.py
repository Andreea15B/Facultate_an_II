#!/bin/python

# Program care realizeaza proceseaza un document XML prin DOM
# Autor: Sabin-Corneliu Buraga -- https://profs.info.uaic.ro/~busaco/
# Ultima actualizare: 20 martie 2009

import urllib
import xml.dom

from xml.dom.minidom import parse

print 'Incercam sa procesam documentul XML...'

try:
   # incarcam documentul
   doc = urllib.urlopen('projects.xml')
   # il procesam
   dom = parse(doc)
   # preluam elementul-radacina
   radacina = dom.documentElement
   print 'Elementul radacina este <' + radacina.tagName + '>'
   # parcurgem elementele <project> si oferim informatii despre fiecare
   for proiect in dom.getElementsByTagName('project'):
      print 'Proiectul ' + proiect.childNodes[1].firstChild.nodeValue + \
            ' este de clasa: ' + proiect.getAttribute('class')
except Exception:
   print 'Din pacate, a aparut o exceptie :('