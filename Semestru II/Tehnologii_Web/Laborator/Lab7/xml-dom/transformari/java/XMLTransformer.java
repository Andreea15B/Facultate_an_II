/* Program Java care realizeaza transformari XSL

   A se compila cu: javac XMLTransformer.java
   A se executa cu: java XMLTransformer

   Autor: Sabin-Corneliu Buraga (2007) -- http://www.infoiasi.ro/~busaco/
   Ultima actualizare: 18 martie 2007
*/
import javax.xml.transform.*;
import javax.xml.transform.stream.*;

public class XMLTransformer {

	// 'programul' principal
	// args[0] reprezinta URI-ul documentului XML
	// args[1] reprezinta URI-ul documentului XSLT
	public static void main (String[] args) {

		if (args.length != 2) {
      System.err.println
        ("Realizeaza transformari XSL.\nSintaxa: XMLTransformer <document.xml> <foaie.xsl>");
      return;
    }

		// instantieri...
		TransformerFactory tr = TransformerFactory.newInstance();
		Transformer trans;

		try {
			// cream un transformator, folosind foaia de stiluri XSLT
			trans = tr.newTransformer (new StreamSource (args[1]));
			// cream sursa de date XML (aici, un fisier)
			StreamSource xml = new StreamSource (args[0]);
			// rezultatul transformarii e redirectionat spre iesirea standard
			StreamResult rez = new StreamResult (System.out);
			// realizam transformarea
			trans.transform (xml, rez);
		}
		// tratam exceptiile
		catch (TransformerConfigurationException e) {
			System.err.println ("Eroare la initializare.\n" + e);
		}
		catch (TransformerException e) {
			System.err.println ("Eroare la transformare.\n" + e);
		}
	}
}