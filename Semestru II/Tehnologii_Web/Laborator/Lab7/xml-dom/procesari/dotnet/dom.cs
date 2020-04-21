/*
   Un program C# utilizat la parcurgerea unui document XML,
   folosind modelul DOM (clasa XmlDocument) 
   (dupa documentatia insotind .NET Framework) 
 
   A se compila cu: csc dom.cs
   A se executa cu: dom
   
   Autor: Sabin Buraga - https://profs.info.uaic.ro/~busaco/
   Portiuni din acest program apartin Microsoft (c)2001-2002
   Ultima actualizare: 04 noiembrie 2004
*/
using System;
using System.IO;
using System.Xml;

namespace csbXMLTools
{
  class DOMProcessor // clasa de procesare via DOM
  {
    private static XmlDocument doc;
    
    public static void Main()
    {
      try 
      {
        // instantiem un document XML spre a fi incarcat  
        doc = new XmlDocument();
        doc.Load("projects.xml");

        // adaugam o functie de tratare a evenimentului de inserare 
        // a unui nod in arborele DOM        
        doc.NodeInserted += 
          new XmlNodeChangedEventHandler(NodeInsertedHandler);

        // afisam informatii generale despre document
        XmlElement root = doc.DocumentElement;  
        Console.WriteLine("Spatiul de nume are URI-ul {0}.",        
          root.NamespaceURI);  
        Console.WriteLine("Elementul radacina este <{0}>.", 
          root.Name);
    
        // afisam informatii privitoare la proiecte
        XmlNodeList projs = doc.GetElementsByTagName("project");
        foreach(XmlElement proj in projs)
        {  
           // selectam nodurile <title> 
           XmlNodeList titles = proj.SelectNodes("./title");
           foreach (XmlElement title in titles) {
             Console.Write("Proiect: {0} ", title.InnerXml);
           }
           // verificam care e clasa proiectului
           if (proj.HasAttribute("class") == true) {
             Console.WriteLine("de clasa '{0}'.", 
               proj.GetAttribute("class")); 
               // sau, mai putin exact: proj.Attributes[0].Value); 
           }
           else {
             Console.WriteLine("de clasa necunoscuta.");
             // nu exista atributul "class", il cream
             XmlNode attr = doc.CreateNode(XmlNodeType.Attribute, "class", "");
             attr.Value = "D"; // implicit, proiectul e de clasa D :)
             // atasam nodul creat listei atributelor elementului <project>
             proj.Attributes.SetNamedItem(attr);
           }    
        }
      } // final de "try"
      catch ( Exception e ) 
      {
      	// a aparut o exceptie
      	Console.WriteLine("Exceptie: " + e.Message);
      	return;
      }
      // gata!
    } // final de program 'principal'

    // metoda de tratare a evenimentului de inserare 
    // a unui nod in arborele DOM    
    private static void NodeInsertedHandler(Object src, 
      XmlNodeChangedEventArgs args)
    {
       Console.WriteLine("A fost inserat un nod de tip {0}.", 
         args.Node.NodeType);
       
       // salvam, indentat, documentul intr-un fisier
       // (numai in cazul in care a fost inserat atributul 'class')
       if (args.Node.NodeType != XmlNodeType.Attribute)
         return;
       try {
         XmlTextWriter writer = new XmlTextWriter("projects2.xml", null);
         writer.Formatting = Formatting.Indented;
         doc.Save(writer);
         writer.Close();
         Console.WriteLine("Documentul XML a fost salvat.");
       }
       catch ( Exception e )
       {
          // a aparut o exceptie
      	  Console.WriteLine("Exceptie: " + e.Message);
      	  return; 
       }  
    }
  }     
}
