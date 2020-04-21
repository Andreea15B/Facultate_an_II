// Exemplu de serializare/deserializare XML
// Autor: Sabin-Corneliu Buraga (c)2004, 2006
// Portiuni din codul acestui program apartin Microsoft
using System;
using System.IO;
using System.Xml;
using System.Xml.Serialization;

[XmlRootAttribute("Cadouri", Namespace="http://www.mag.ro/produse", 
IsNullable = false)]
public class Cadouri : Object {
  public Cadou cadou;
}
public class Cadou {
  // va fi serializat, chiar daca are valoarea 'null'		
  [XmlElementAttribute(IsNullable = false)] 
  public int bucati;
  // la serializare, se va numi 'produs' si nu 'nume'
  [XmlElementAttribute("produs")]
  public string nume;
  // va fi serializat ca un atribut, nu ca un element
  [XmlAttribute] 
  public double pret;
}   	

class SerializareXML {
   public static void Main () {
      Cadou unCadou = new Cadou();
      unCadou.bucati = 1;
      unCadou.nume = "hipomotan"; 
      unCadou.pret = 100.50;
      
      Cadouri cadouriMoko = new Cadouri();
      cadouriMoko.cadou = unCadou;
      SalveazaCadouri (cadouriMoko, "cadouri-moko.xml");
      
      unCadou.bucati = 2;
      unCadou.nume = "banchiz&#259; cu <ferestre>"; 
      unCadou.pret = 30.25;
      
      Cadouri cadouriTux = new Cadouri();
      cadouriTux.cadou = unCadou;
      SalveazaCadouri (cadouriTux, "cadouri-tux.xml");
      
      // deserealizam un obiect
      XmlSerializer ser = new XmlSerializer(typeof(Cadouri));

      // alteram obiectul original
      cadouriTux.cadou.nume = "ochelari";
      Console.WriteLine("Tux va primi {0}.", cadouriTux.cadou.nume);
      // vom citi documentul XML prin XmlReader
      Stream flux = new FileStream ("cadouri-tux.xml", FileMode.Open);
      XmlReader cititor = new XmlTextReader (flux);
      // datele deserializate vor fi stocate tot de 'cadouriTux'
      cadouriTux = (Cadouri) ser.Deserialize(cititor);
      Console.WriteLine("Tux va primi {0}.", cadouriTux.cadou.nume);
   }
      
   // serializeaza un obiect ca document XML   
   static void SalveazaCadouri (Object obiect, string fisier) {
      Stream scriitor = new FileStream (fisier, FileMode.Create);
      try {
        XmlSerializer ser = new XmlSerializer (obiect.GetType());
        ser.Serialize (scriitor, obiect);
      }
      catch (Exception e) {
      	// a aparut o exceptie
      	Console.WriteLine("Exceptie la serializare: " + e.Message);
      	return;
      }
      finally {
        scriitor.Close();
      }
   }  
}  