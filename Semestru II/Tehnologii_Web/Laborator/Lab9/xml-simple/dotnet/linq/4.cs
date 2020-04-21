/* Program C# ce incarca un document XML si elimina apoi elementele <url>,
 * salvand in final arborele intr-un alt fisier XML
 * Observatii:
 *   - arborele XML e traversat recursiv, fiind returnate doar acele elemente care au numele "url"
 *   - "Where" are rolul de a filtra elementele pe baza unui criteriu
 *   - in final, este apelata metoda Remove(), pentru a elimina elementele dorite
 *   - xproj.Descendants() returneaza toti copiii unui nod
 *   - este creata o secventa IEnumerable<T>, asupra careia se executa metoda Remove()
 
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
        static void Main (string[] args)
        {
            XDocument xproj = XDocument.Load (@"C:\projects.xml");
           
            xproj.Descendants ().Where (e => e.Name == "url").Remove();
            System.Console.WriteLine (xproj);
            xproj.Save (@"C:\projects2.xml");
        }
    }
}