/* Program C# care incarca (binecunoscutul) document projects.xml
 * si adauga la fiecare proiect din lista un student care a ales proiectul,
 * precum si data la care s-a facut alegerea (data este preluata din sistem)
 * Observatii:
 *  - se urmareste exemplificarea modului in care se adauga elemente si atribute intr-un arbore XML
 
 * Realizat de Emil-Mircea Andriescu si Ionut Ignatescu
 * Permisiunile de utilizare sunt cele stipulate de Creative Commons 
   Attribution-NonCommercial-ShareAlike 2.5 License: 
   http://creativecommons.org/licenses/by-nc-sa/2.5/   
 */
using System;
using System.Xml.Linq;

namespace LINQExample
{
    class Program
    {
        static void Main (string[] args)
        {
          XElement projects = XElement.Load (@"C:\projects.xml");
          int i = 1;
          Random rand = new Random ();

          foreach (XElement elem in projects.Elements())
          {
             XElement e = new XElement ("student", "Student_" + i);
             XAttribute at = new XAttribute ("grupa", "I20" + rand.Next (12));
             e.Add (at);
             XElement e2 = new XElement("data", System.DateTime.Today);
             i++;
             elem.Add (e);
             elem.Add (e2);
                
             Console.WriteLine (elem.ToString ());
          }
          projects.Save (@"C:\projects2.xml");  
        }
    }
}
