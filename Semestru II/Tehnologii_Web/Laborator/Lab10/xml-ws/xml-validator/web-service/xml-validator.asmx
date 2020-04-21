/* Exemplu de serviciu Web implementat in C# care verifica
   daca un document XML (aflat pe server) este valid

   Autor: Sabin-Corneliu Buraga - http://profs.info.uaic.ro/~busaco/
   Ultima actualizare: 24 noiembrie 2007
*/

<%@ WebService language="C#" class="XMLValidator" %>

using System;
using System.Web.Services;
using System.Xml;
using System.Xml.Serialization;
using System.Xml.Schema;
using System.IO;

// clasa utilizata pentru implementarea serviciului Web
[WebService(Namespace="http://www.infoiasi.ro/XMLValidator")]
public class XMLValidator {

    static private int validationMessages;
    static private string result;
    
    // locatia unde se stocheaza documentele XML
    string path = @"d:\xml-files\";
  
    // metoda Web care verifica existenta unui fisier XML
    [WebMethod]
    public bool CheckIfExists(string filename) {
      return File.Exists(path + filename);
    }

    // metoda Web de validare a unui fisier XML
    [WebMethod]
    public string Validate(string filename) {

      // cititorul de documente XML
      XmlReader r = null;
      // initial nici o eroare
      validationMessages = 0;
      result = "";

      // incercam sa procesam documentul XML
      try
      {
        XmlReaderSettings settings = new XmlReaderSettings();
        
        // stabilim maniera de validare (aici, XML Schema)
        settings.ValidationType = ValidationType.Schema;
        settings.Schemas.Add("xsdCuprins", path + "cuprins.xsd");
        settings.ValidationEventHandler += new ValidationEventHandler(ValidationHandler);
        
        // cream cititorul XML
        r = XmlReader.Create(path + filename, settings);

        while ( r.Read() )
          ; // nu facem nimic, doar citim documentul XML
      } // final de "try"
      catch ( Exception e )
      {
      	return result + e.Message; // returnam mesajul de exceptie
      }
      finally {
      	// la final, iesim 'gratios'
      	if ( r != null )
      	  r.Close();
      }
      // gata!
      // returnam succes sau numarul de erori
      return (validationMessages == 0 ?
        "valid" : "invalid (" + validationMessages + ")");
    }

    // metoda de tratare a erorilor de validare
    private static void ValidationHandler(object sender,
                                         ValidationEventArgs args)
    {
       result += args.Severity + "(" + args.Message + "). ";
       validationMessages++;
    }

} // final de clasa
