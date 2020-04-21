/* Program C# ce afiseaza la iesire mesajul "Hello LINQ", extras in urma unei 
   "interogari" asupra unei colectii de siruri de caractere
 
   Realizat de Emil-Mircea Andriescu si Ionut Ignatescu
   Permisiunile de utilizare sunt cele stipulate de Creative Commons 
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
            string[] greetings = { "Salut Tuxy", "Salut Pingu", "Salut iarasi Tuxy" };
            var items =
              from s in greetings
              where s.EndsWith ("Tuxy")
              select s;
            foreach (var item in items)
              Console.WriteLine(item);
        }
    }
}
