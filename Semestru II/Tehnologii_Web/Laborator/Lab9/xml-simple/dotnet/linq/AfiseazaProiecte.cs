/*
   Un program C# utilizat pentru procesarea unui document XML memorind liste de proiecte
   prin intermediul LINQ.
   
   Necesita .NET Framework 3.5 instalat.
 
   Autor: Sabin Buraga - http://www.infoiasi.ro/~busaco/
   Ultima actualizare: 30 martie 2008
*/
using System;
using System.Collections;
using System.Linq;
using System.Xml.Linq;
using System.Xml.XPath;

namespace AfiseazaProiecte
{
    class AfiseazaProiecte
    {
        static void Main(string[] args)
        {
            XDocument proiecte;
            try
            {
                // incarcam documentul XML cu lista proiectelor
                proiecte = XDocument.Load("projects.xml");
            }
            catch (Exception e)
            {
                Console.WriteLine("A aparut o problema la incarcarea documentului: " + e.Message);
                return;
            }
            var proiecteA =
                from p in proiecte.Descendants("project") // preluam toate proiectele
                where (String)p.Attribute("class") == "A" // din care le alegem pe cele de clasa 'A',
                orderby (String)p.Element("stud")         // ordonate dupa numarul de studenti,
                select (String)p.Element("title");        // selectind doar titlul acestora
            // afisam titlul proiectelor de clasa 'A'
            foreach (var proiect in proiecteA)
            {
                Console.WriteLine(proiect);
            }
            
            // aceeasi constructie de mai sus, de data aceasta folosind XPath
            var proiecteA2 =  (IEnumerable)proiecte.XPathEvaluate("//project[@class='A']/title");
            // afisam titlul proiectelor de clasa 'A'
            foreach (var proiect in proiecteA2)
            {
                Console.WriteLine(proiect);
            }
        }
    }
}
