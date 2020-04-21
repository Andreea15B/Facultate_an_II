// Exemplu de utilizare a clasei XmlWriter din .NET
// Autor: Sabin-Corneliu Buraga (c)2004, 2006
// Portiuni din codul acestui program apartin Microsoft
using System;
using System.IO;
using System.Xml;

class XmlWriter {
   public static void Main () {
      // valorile elementului 'cadou'	
      string[] cadouri = { "banchiza", "ferestre & arcuri" }; 
      
      StringWriter scriitor = new StringWriter();
      XmlTextWriter scriitorXML = new XmlTextWriter(scriitor);
      // stabilim modul de formatare
      scriitorXML.Formatting = Formatting.Indented;
      // inceput de document
      scriitorXML.WriteStartDocument(); 
      scriitorXML.WriteComment(" Generat de XmlWriter ");
      // includem o instructiune de procesare pentru foi de stiluri
      scriitorXML.WriteProcessingInstruction("xml-stylesheet", 
        "type='text/xsl' href='cadouri.xsl'");
      // inseram elementele dorite
      scriitorXML.WriteStartElement("cadouri");
      scriitorXML.WriteStartAttribute("persoana", 
        "http://undeva.ro/persoane/");
      scriitorXML.WriteString("Tux");
      scriitorXML.WriteEndAttribute();
      foreach (string cadou in cadouri) { // includem cadourile
      	scriitorXML.WriteElementString ("cadou", 
          "urn:mag.ro:produse", cadou);        
      }	
      // inseram si un cadou surpriza
      scriitorXML.WriteStartElement("cadou");
      scriitorXML.WriteCData("<surpriza>");
      scriitorXML.WriteEndElement();
      scriitorXML.WriteEndElement();
      // am terminat
      scriitorXML.WriteEndDocument();
      scriitorXML.Flush(); // eliberam bufferul intern

      // afisam la iesirea standard
      Console.WriteLine(scriitor.ToString());
      scriitorXML.Close();
      scriitor.Close();
   }
}
