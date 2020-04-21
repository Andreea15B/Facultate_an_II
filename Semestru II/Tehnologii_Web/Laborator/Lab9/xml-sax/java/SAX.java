/* Program Java care proceseaza prin SAX un document XML 

   A se compila cu: javac SAX.java
   A se executa cu: java SAX   
   
   Autor: Sabin Corneliu Buraga (2005, 2007)
   Ultima actualizare: 29 martie 2007
*/   
import java.util.Stack;
import java.io.IOException;
import org.xml.sax.*;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.XMLReaderFactory;

// clasa de tratare a evenimentelor de procesare SAX
class ProiecteSAX extends DefaultHandler {
  private Stack stiva = new Stack (); // stiva de elemente

  // metoda de tratare a evenimentului 'inceput de tag'
  public void startElement (String uri, String local, String qName, 
	                    Attributes atts) throws SAXException {
    stiva.push (new String(qName)); // introducem in stiva
    
    if (qName.equals ("project")) { // afisam daca e de clasa A
      System.out.print ("<proiect");
      String clasa;
      clasa = atts.getValue ("class");	
      if (clasa.equals ("A")) {
        System.out.print (" clasa='A'");
      }
      System.out.print (">");
    }
  }

  // metoda de tratare a evenimentului 'final de tag'
  public void endElement (String uri, String local, String qName)
  throws SAXException {
    if (qName.equals ("project"))
      System.out.println ("</proiect>");
    stiva.pop (); // eliminam elementul din stiva
  }

  // metoda de tratare a evenimentului 'continut text'
  public void characters (char buf [], int offset, int length)
  throws SAXException {
    Object top = stiva.peek ();  // preluam virful stivei
    if (!top.equals ("title"))   // nu e element 'title'
      return;
    // afisam continutul text  
    for (int i = 0; i < length; i++)
      System.out.print (buf[offset + i]);	
  }
}

// clasa de procesare SAX
public class SAX {
  // argv[0] reprezinta URI-ul documentului XML
  public static void main (String argv []) {
    XMLReader    prod; // producatorul SAX
    ProiecteSAX  cons; // consumatorul SAX

    if (argv.length != 1) { 
      System.err.println 
        ("Proceseaza XML prin SAX.\nSintaxa: SAX <fisier.xml>");
      return;
    }  	
    // instantiem procesorul SAX
    try {
      prod = XMLReaderFactory.createXMLReader ();
    } catch (SAXException e) {
      System.err.println ("Eroare de creare a procesorului SAX: "
        + e.getMessage ());
      return;
    }

    try {
      // consumam toate evenimentele SAX
      cons = new ProiecteSAX ();
      // stabilim maniera de tratare a continutului
      prod.setContentHandler (cons);
      // stabilim maniera de raportare a erorilor
      prod.setErrorHandler (cons);
    } catch (Exception e) { // exceptie
    	  System.err.println ("Exceptie :" + e.getMessage ());
        return;
    }

    // startam procesarea SAX (producerea de evenimente)
    try {
      prod.parse (argv [0]);
    } catch (IOException e) { // tratam exceptiile
        System.err.println ("Eroare I/O: ");
        e.printStackTrace ();
    } catch (SAXException e) {
        System.err.println ("Eroare de procesare: ");
        e.printStackTrace ();
    }
  }
}