#!/bin/python

# Program care realizeaza procesarea minimala a unui document XML prin SAX
# Autor: Sabin-Corneliu Buraga -- http://profs.info.uaic.ro/~busaco/
# Ultima actualizare: 13 aprilie 2016

import string
import urllib
import xml.sax

# clasa definind metodele de tratare a evenimentelor SAX 
class ContentHandler(xml.sax.handler.ContentHandler):
   def startElement(self, tag, attrs): # inceput de tag
      print '<' + tag + '>'
   def endElement(self, tag):          # final de tag
      print '</' + tag + '>' 
   def characters(self, content):      # continut textual
      print string.strip(content)

# clasa de tratare a erorilor de procesare
class ErrorReporter(xml.sax.handler.ErrorHandler):
   def error(self, exception):
      print 'Eroare: ' + exception.getMessage()
      raise exception
   def fatalError(self, exception):
      print 'Eroare fatala: ' + exception.getMessage()
      raise exception
   def warning(self, exception):
      print 'Avertisment: ' + exception.getMessage()


print 'Incercam sa procesam documentul XML...'
# incarcam documentul
doc = urllib.urlopen('cuprins.xml')
try:
   xml.sax.parse(doc, ContentHandler(), ErrorReporter())
   print 'Gata!'
except xml.sax.SAXException:
   pass   