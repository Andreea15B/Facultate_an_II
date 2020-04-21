/*
   Un program C# utilizat la validarea documentelor XML 
   prin intermediul schemelor XML sau prin specificatii DTD
   (dupa documentatia insotind .NET Framework) 
 
   A se compila cu: csc xml-validator.cs
   A se executa cu: xml-validator <fisier.xml> [ --dtd | -d ]
   
   Autor: Sabin Buraga - https://profs.info.uaic.ro/~busaco/
   Portiuni din acest program apartin Microsoft (c)2001-2002
   Ultima actualizare: 25 octombrie 2003
*/
using System;
using System.IO;
using System.Xml;
using System.Xml.Schema;

namespace csbXMLTools
{
  	
  class XMLValidator // clasa de validare a documentelor XML
  {
    // numarul mesajelor emise de validator (erori, avertismente,...)	
    private static int validationMessages = 0;  
    
    // 'programul' principal
    public static void Main(string[] args)
    {
      // contine tipul validarii (XML Schema ori DTD)	
      string validType;
      
      Console.WriteLine("xml-validator 0.5");
      // n-au fost furnizate argumente
      if ( args.Length == 0 )
      {
        Console.WriteLine("Sintaxa: xml-validator <fisier.xml> [ --dtd | -d ]\n");
        Console.WriteLine("Validator de documente XML (implicit se foloseste XML Schema).");
        Console.WriteLine("Folositi optiunea \"--dtd\" (sau \"-d\") pentru o validare prin DTD.");
        return;
      }	
      
      // cititorul si validatorul de documente XML
      XmlTextReader tr = null;
      XmlValidatingReader vr = null;
      
      // incercam sa procesam documentul XML
      try 
      {
      // instantiem cititorul de continut XML	
      tr = new XmlTextReader(args[0]);	
      // instantiem validatorul XML 
      vr = new XmlValidatingReader(tr);
      // setam tipul de validare
      if ( args.Length >= 2 && (args[1] == "--dtd" || args[1] == "-d") ) 
      {
      	vr.ValidationType = ValidationType.DTD;
      	validType = "DTD";
      }
      else 
      {	
        // tipul implicit de validare foloseste XML Schema
        vr.ValidationType = ValidationType.Schema;
        validType = "XML Schema";
      }  
      Console.WriteLine("\nDocumentul XML care va fi validat prin {0} este {1}...", 
        validType, args[0]);
      
      // setam o metoda de semnalare a evenimentelor generate
      // de validatorul XML
      vr.ValidationEventHandler += 
        new ValidationEventHandler (ValidationHandler);

      // parcurgem documentul XML si afisam informatii 
      // despre elementele si atributele sale
      while ( vr.Read() )
      {
        PrintTypeInfo(vr, "node");
        // nu afisam informatii decit daca se face o validare prin scheme XML
        if ( validType != "DTD" && vr.NodeType == XmlNodeType.Element )
        {
          while ( vr.MoveToNextAttribute() )
            PrintTypeInfo(vr, "attr");
        }
      }
      } // final de "try"
      catch ( Exception e ) 
      {
      	// a aparut o exceptie
      	Console.WriteLine("Exceptie: " + e.Message);
      	return;
      }
      finally {
      	// la final, iesim 'gratios' 
      	if ( tr != null )
      	  tr.Close();
      	if ( vr != null )
      	  vr.Close();
      }	    	
      // gata!
      Console.WriteLine("Validarea s-a terminat cu {0}.", 
        validationMessages == 0 ? "succes" : validationMessages + " erori");
    }
    
    // metoda de afisare a informatiilor despre nodurile arborelui 
    // asociat documentului XML de validat
    public static void PrintTypeInfo(XmlValidatingReader vr, string attrInfo)
    {
      // siruri folosite la afisarea diferita 
      // a datelor despre atribute & elemente
      string prefix = ( attrInfo == "attr" ) ? "*  " : "";
      string leftDelim = ( vr.NodeType == XmlNodeType.Element ) ? "<" : "\'";
      string rightDelim = ( vr.NodeType == XmlNodeType.Element ) ? ">" : "\'";
      
      if ( vr.SchemaType != null )
      {
      	// daca tipul de schema este DTD sau simplu (demodat)
        if ( vr.SchemaType is XmlSchemaDatatype || 
             vr.SchemaType is XmlSchemaSimpleType )
        {
          object value = vr.ReadTypedValue();
          // afisam tipul nodului, numele, tipul valorii si valoarea
          Console.WriteLine(prefix + "{0} " + leftDelim + "{1}" + rightDelim + 
            " de tip {2} = \"{3}\"", 
            vr.NodeType, vr.Name, value.GetType().Name, value);
        }
        // daca tipul este schema complexa (conform recomandarii W3C)
        else if ( vr.SchemaType is XmlSchemaComplexType )
            {
               XmlSchemaComplexType sct = (XmlSchemaComplexType)vr.SchemaType;
               // afisam tipul nodului, numele nodului si numele tipului complex
               Console.WriteLine(prefix + "{0} " + leftDelim + "{1}" + 
                 rightDelim + " de tip {2}", vr.NodeType, vr.Name, sct.Name);
            }
      }
    }

    // metoda de tratare a erorilor de validare
    public static void ValidationHandler(object sender, 
                                         ValidationEventArgs args)
    {
       Console.WriteLine("Eroare de validare:");
       // eroare sau avertisment
       Console.WriteLine("\tTip: {0}", args.Severity);
       Console.WriteLine("\tMesaj: {0}", args.Message);
       validationMessages++;
    }
  } // final de clasa
} // final de spatiu de nume  
