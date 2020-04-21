/* Program C# care genereaza un document XML cu urmatoarea structura:
 <studenti>
  <student nr_matricol="187...1">
    <prenume>Prenume_1</prenume>
    <nume>Nume_1</nume>
    <an>2</an>
  ...
 </studenti> 
 
 * Realizat de Emil-Mircea Andriescu si Ionut Ignatescu
 * Permisiunile de utilizare sunt cele stipulate de Creative Commons 
   Attribution-NonCommercial-ShareAlike 2.5 License: 
   http://creativecommons.org/licenses/by-nc-sa/2.5/   
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

namespace LINQExample
{
    class Program
    {
        static void Main(string[] args)
        {
            XElement studenti = new XElement ("studenti");
            for (int i = 1; i <= 5; i++)
            {
                studenti.Add(
                    new XElement("student",
                    new XAttribute("nr_matricol", "187..." + i),
                    new XElement("prenume", "Prenume_" + i),
                    new XElement("nume", "Nume_" + i),
                    new XElement("an", i % 3 + 1)));
                    
            }
            studenti.Save (@"C:\studenti.XML");
            // pentru a incarca un document XML se foloseste:
			// XElement incarca_studenti= XElement.Load (@"c:\studenti.xml");
         }
    }
}