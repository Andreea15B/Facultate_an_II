/*
   Un program C# utilizat la transformarea, 
   via o foaie XSL, a documentelor XML 
   (varianta pentru .NET Framework 2.0) 
 
   A se compila cu: csc xml-transformer.cs
   A se executa cu: xml-transformer <fisier.xml> <fisier.xsl>
   
   Autor: Sabin Buraga -- http://www.purl.org/net/busaco
   Portiuni din acest program apartin Microsoft
   Ultima actualizare: 18 octombrie 2007
*/
using System;
using System.IO;
using System.Xml;
using System.Xml.Xsl;
using System.Xml.XPath;

namespace csbXMLTools
{
  class XMLTransformer // clasa de transformare a documentelor XML
  {
  		
    // 'programul' principal
    public static void Main(string[] args)
    {
      // n-au fost furnizate suficiente argumente
      if ( args.Length < 2 )
      {
        Console.WriteLine("Sintaxa: xml-transformer <fisier.xml> <fisier.xsl>\n");
        Console.WriteLine("Transforma documente XML folosind o foaie XSL.");
        return;
      }	
      
      // instanta a clasei de transformare optimizata
      XslCompiledTransform xslt = null;
      
      // incercam sa procesam documentul XML
      try 
      {
      // instantiem cititorul de continut XML	
      xslt = new XslCompiledTransform();
      
      // incarcam foaia de stiluri XSL
      xslt.Load(args[1]);
	
      // realizam transformarea
      xslt.Transform(new XPathDocument(args[0]), 
                     new XmlTextWriter(Console.Out));

      } // final de "try"
      catch ( Exception e ) 
      {
      	// a aparut o exceptie
      	Console.WriteLine("Exceptie: " + e.Message);
      	return;
      }
      // gata!
    }    
    
  } // final de clasa
} // final de spatiu de nume  
