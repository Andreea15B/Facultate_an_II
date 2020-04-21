/*
   Un program C# utilizat la indentarea unui document XML 
   (dupa documentatia insotind .NET Framework) 
 
   A se compila cu: csc xml-indenter.cs
   A se executa cu: xml-indenter <fisier.xml>
   
   Autor: Sabin Buraga -- http://www.purl.org/net/busaco
   Portiuni din acest program apartin Microsoft (2001-2002)
   Ultima actualizare: 14 noiembrie 2004
*/
using System;
using System.IO;
using System.Xml;

namespace csbXMLTools
{
  public class XMLIndenter { // clasa de indentare a unui document XML
    // indica de cite ori va fi aplicat sirul de indentare
    private static int indent = 0; 
    // reprezinta sirul de indentare  
    private static string indentStr = "  ";
    
    public static void Main(string[] args) { // 'programul' principal
  
      // n-au fost furnizate argumente
      if ( args.Length == 0 )
      {
        Console.WriteLine("Sintaxa: xml-indenter <fisier.xml>\n");
        Console.WriteLine("Indenteaza un document XML.");
        return;
      }	

      XmlTextReader reader = null;

      try {
       
        // incarcam documentul, ignorind spatiile albe
        reader = new XmlTextReader(args[0]);
        reader.WhitespaceHandling = WhitespaceHandling.None;

        // procesam fisierul si afisam la consola fiecare nod, 
        // in functie de tipul lui
        while (reader.Read()) {
           switch (reader.NodeType) {
             case XmlNodeType.Element: // element XML
               WriteIndentStr();
               Console.Write("<{0}", reader.Name);
               // afisam posibilele atribute ale elementului
               WriteAttributes(reader);
               Console.WriteLine(">");
               indent++;
               break;
             case XmlNodeType.Text:    // continut text
               WriteIndentStr();
               Console.WriteLine(reader.Value);
               break;
             case XmlNodeType.CDATA:   // sectiune CDATA
               Console.Write("<![CDATA[{0}]]>", reader.Value);
               break;
             case XmlNodeType.ProcessingInstruction: 
                                       // instructiune de procesare
               Console.WriteLine("<?{0} {1}?>", reader.Name, reader.Value);
               break;
             case XmlNodeType.Comment: // comentariu
               Console.WriteLine("<!--{0}-->", reader.Value);
               break;
             case XmlNodeType.XmlDeclaration: 
                                       // declaratie XML
               Console.WriteLine("<?xml version=\"1.0\" ?>");
               break;
             case XmlNodeType.Document:// inceput de document
               break;
             case XmlNodeType.DocumentType:
                                       // declaratie DTD
               Console.WriteLine("<!DOCTYPE {0} [{1}]>", 
                 reader.Name, reader.Value);
               break;
             case XmlNodeType.EntityReference:
                                       // referinta la o entitate
               Console.Write(reader.Name);
               break;
             case XmlNodeType.EndElement:
                                       // sfirsit de element (tag)
               indent--;
               WriteIndentStr();
               Console.WriteLine("</{0}>", reader.Name);
               
               break;
           } // switch      
        //WriteIndentStr();   
        } // while 
      } // final de 'try'
      catch ( Exception e ) 
      {
      	// a aparut o exceptie
      	Console.WriteLine("Exceptie: " + e.Message);
      	return;
      }
      // la final, iesim 'gratios'
      finally {
        if (reader != null)
          reader.Close();
      }
    }
  
    // afiseaza atributele unui element
    public static void WriteAttributes(XmlReader reader) {
      if (reader.HasAttributes) {
        for (int i = 0; i < reader.AttributeCount; i++) {
          reader.MoveToAttribute(i); // baleiam atributele
          Console.Write(" {0}=\"{1}\"", reader.Name, reader.Value);
        }
        reader.MoveToElement(); // ne reintoarcem la nodul-element
      }
    } // final de metoda
    
    // afiseaza sirul de indentare a elementelor
    private static void WriteIndentStr() {
      for (int i = 0; i < indent; i++) {
       	Console.Write(indentStr);
      }		
    } // final de metoda	

  } // final de clasa
} // final de spatiu de nume
