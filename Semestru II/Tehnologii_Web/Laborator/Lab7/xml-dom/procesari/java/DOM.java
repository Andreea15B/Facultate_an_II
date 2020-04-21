/* Program Java care proceseaza prin DOM un document XML.
   Se afiseaza numarul atributelor corespunzatoare fiecarui element 
   specificat in cadrul unui document XML. 

   A se compila cu: javac DOM.java
   A se executa cu: java DOM   
   
   Autor: Sabin Corneliu Buraga (2004, 2005)
   Ultima actualizare: 21 noiembrie 2005
*/
import org.w3c.dom.*; 
import javax.xml.parsers.*; 

// clasa de procesare DOM
public class DOM {
  // argv[0] reprezinta URI-ul documentului XML
  public static void main (String argv []) {       
    if (argv.length != 1) {
      System.err.println 
        ("Proceseaza XML prin DOM.\nSintaxa: DOM <fisier.xml>");
      return;
    }
        
    try {
      // instantieri...
      DocumentBuilderFactory dbf 
        = DocumentBuilderFactory.newInstance();
      DocumentBuilder docb = dbf.newDocumentBuilder();
      // pregatim procesarea documentului
      Document doc = docb.parse(argv[0]); 
      // traversam recursiv arborele DOM
      traverseaza (doc.getDocumentElement());
    } catch (Exception e) {
        System.err.println ("Eroare de procesare DOM: ");
	      e.printStackTrace ();
    }
  }
  
  // traverseaza recursiv un arbore DOM 
  static private void traverseaza (Node nod) {
    // afisam numele nodurilor de tip element, 
    // plus numarul de atribute
    if (nod.getNodeType() == Node.ELEMENT_NODE) {
      System.out.println ("Elementul '" + nod.getNodeName() + 
        "' are " + nod.getAttributes().getLength() + " atribute.");      	
    }
    // continuam traversarea...
    Node copil = nod.getFirstChild(); // primul copil
    if (copil != null) 
      traverseaza (copil);
    copil = nod.getNextSibling();     // urmatorul 'frate'
    if (copil != null)
      traverseaza (copil);
  }	  	
}
