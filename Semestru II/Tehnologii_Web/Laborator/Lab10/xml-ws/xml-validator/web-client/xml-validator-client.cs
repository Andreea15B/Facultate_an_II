/*
   Un program-client C# utilizat la validarea documentelor XML, 
   invocand metode ale unui serviciu Web via un proxy generat automat
   
   Autor: Sabin-Corneliu Buraga - http://profs.info.uaic.ro/~busaco/
   Ultima actualizare: 24 noiembrie 2007
*/
using System;

class XMLValidatorClient {
   public static void Main(string[] args) {
     
     if (args.Length == 0) {
     	  Console.WriteLine("Client de validare via un serviciu Web a unui document XML stocat pe server.");
     	  Console.WriteLine("Sintaxa: xml-validator-client <document.xml>");
     	  return;
     }
     
     try {
     	Console.Write("Documentul '{0}' este... ", args[0]);
        // cream o instanta a clasei corespunzatoare serviciului Web     
        XMLValidator validator = new XMLValidator();
     
        // invocam metoda de verificare a existentei fisierului
        if (validator.CheckIfExists(args[0])) {
          // exista, deci putem realiza validarea
          string valid = validator.Validate(args[0]);
          // afisam ce a returnat metoda Validate() invocata 
          Console.WriteLine(valid + ".");
        }   
        else      
          Console.WriteLine("inaccesibil (nu exista pe server?).");
     } // final de 'try'
     catch (Exception e) {
        // a aparut o exceptie
      	Console.WriteLine("\nExceptie: " + e.Message);
      	return;
     }	     
  }  
} // final de clasa
