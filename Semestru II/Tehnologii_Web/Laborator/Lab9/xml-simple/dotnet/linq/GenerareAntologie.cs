/*
   Un program C# utilizat pentru crearea si parcurgerea unui document XML prin intermediul LINQ.
   Necesita .NET Framework 3.5 instalat.
 
   A se compila cu: csc GenerareAntologie.cs /reference:"c:\Program Files\Reference Assemblies\Microsoft\Framework\v3.5\System.Xml.Linq.dll"
   A se executa cu: GenerareAntologie
   
   De asemenea, se poate utiliza Microsoft Visual C# 2008 Express Edition
 
   Autor: Sabin Buraga - http://www.infoiasi.ro/~busaco/
   Portiuni din acest program apartin Microsoft (c)2007
   Ultima actualizare: 30 martie 2008
*/
using System;
using System.IO;
using System.Xml;
using System.Xml.Linq;
using System.Collections;

namespace csbXMLTools
{
    class LINQTest // clasa de procesare via DOM
    {
        private static XElement doc;

        public static void Main()
        {
            // cream un document XML via constructiile functionale oferite de LINQ
            XNamespace sp = "http://www.antologie.info"; // adresa spatiului de nume
            doc = new XElement(   // instantiem un document XML
                new XElement(sp + "antologie",
                    new XAttribute("stare", "ciorna"),
                    new XElement(sp + "poem",
                        new XElement(sp + "titlu", "Aproape vid"),
                        new XElement(sp + "vers", "Un singur vers.")),
                    new XElement(sp + "poem",
                        new XElement(sp + "titlu", "Alt poem"),
                        new XElement(sp + "vers", "Primul vers"),
                        new XElement(sp + "vers", "Al doilea vers"))));
            // parcurgem documentul creat mai sus
            foreach (XNode nod in doc.DescendantsAndSelf())
            {
                Console.WriteLine(nod);
            }
            // ...si il salvam
            doc.Save("antologie.xml");
        }
    }
}
