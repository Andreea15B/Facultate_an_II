/* Program C care parcurge un document XML, 
   folosind functiile xmlTextReader ale bibliotecii libxml
*/
#include <stdio.h>
#include <libxml/xmlreader.h>

/* furnizeaza numele unui nod, primind tipul lui */
char *
furnizeaza_nod (xmlReaderTypes tip)
{
  switch (tip)
    {
    case XML_READER_TYPE_NONE:
      return "";
    case XML_READER_TYPE_ELEMENT:
      return "element";
    case XML_READER_TYPE_ATTRIBUTE:
      return "atribut";
    case XML_READER_TYPE_TEXT:
      return "text";
    case XML_READER_TYPE_CDATA:
      return "CDATA";
    case XML_READER_TYPE_ENTITY:
      return "entitate";
    case XML_READER_TYPE_COMMENT:
      return "comentariu";
    case XML_READER_TYPE_WHITESPACE:
      return "spatiu";
    case XML_READER_TYPE_END_ELEMENT:
      return "final de element";
    case XML_READER_TYPE_XML_DECLARATION:
      return "declaratie XML";
      /* ...si multe altele */
    default:
      return "?";
    }
}

/* proceseaza un nod (ofera informatii despre un nod) */
static void
proceseaza_nod (xmlTextReaderPtr procesor)
{
  xmlChar *nume, *valoare;

  nume = xmlTextReaderName (procesor);
  if (nume == NULL)
    nume = xmlStrdup (BAD_CAST "--");
  valoare = xmlTextReaderValue (procesor);

  /* afisam informatii despre nod (nume, tip si daca e vid) */
  printf ("Nodul '%s' este de tip %s si este %s.\n", nume,
	  furnizeaza_nod (xmlTextReaderNodeType (procesor)),
	  xmlTextReaderIsEmptyElement (procesor) ? "vid" : "nevid");
  xmlFree (nume);

  /* daca nodul are valoare, o afisam */
  if (valoare == NULL)
    printf ("<fara valoare>\n");
  else
    {
      printf ("Valoare: '%s'\n", valoare);
      xmlFree (valoare);
    }
}

/* proceseaza un document XML */
int
proceseaza_xml (char *fisier)
{
  xmlTextReaderPtr procesor;
  int ret;			/* codul returnat */

  /* initializam cititorul XML */
  procesor = xmlNewTextReaderFilename (fisier);
  if (procesor != NULL)
    {
      /* procesam intreg fisierul */
      ret = xmlTextReaderRead (procesor);
      while (ret == 1)		/* mai avem de procesat */
	{
	  proceseaza_nod (procesor);
	  ret = xmlTextReaderRead (procesor);
	}
      /* finalizam procesarea */
      xmlFreeTextReader (procesor);
      if (ret != 0)		/* a intervenit o eroare */
	{
	  fprintf (stderr, "Eroare la procesarea %s.\n", fisier);
	}
    }
  else
    {
      fprintf (stderr, "Eroare la deschiderea %s.\n", fisier);
    }
}

int
main (int argc, char *argv[])	/* 'program'-ul principal */
{
  if (argc < 2)
    {
      fprintf (stderr, "Parcurge documente XML via libxml.\n"
	       "Sintaxa: %s <fisier.xml>\n", argv[0]);
      return (1);
    }
  proceseaza_xml (argv[1]);
  return (0);
}
