/* Program C care realizeaza transformari XSLT via libxslt */
#include <string.h>
#include <libxml/xmlmemory.h>
#include <libxml/debugXML.h>
#include <libxml/HTMLtree.h>
#include <libxml/xmlIO.h>
#include <libxml/DOCBparser.h>
#include <libxml/xinclude.h>
#include <libxml/catalog.h>
#include <libxslt/xslt.h>
#include <libxslt/xsltInternals.h>
#include <libxslt/transform.h>
#include <libxslt/xsltutils.h>

extern int xmlLoadExtDtdDefaultValue;

void
transforma_xml (char *date_xml, char *date_xsl)
{
  xsltStylesheetPtr xslt = NULL;
  xmlDocPtr xml, rezultat;

  /* setam sa se substituie entitatile */
  xmlSubstituteEntitiesDefault (1);
  /* setam sa se incarce entitatile externe */
  xmlLoadExtDtdDefaultValue = 1;
  /* procesam foaia de stiluri XSLT */
  xslt = xsltParseStylesheetFile ((const xmlChar *) date_xsl);
  /* procesam documentul XML */
  xml = xmlParseFile (date_xml);
  /* obtinem rezultatul transformarii */
  rezultat = xsltApplyStylesheet (xslt, xml, NULL);
  /* trimitem rezultatul la iesirea standard */
  xsltSaveResultToFile (stdout, rezultat, xslt);

  /* eliberam memoria */
  xsltFreeStylesheet (xslt);
  xmlFreeDoc (rezultat);
  xmlFreeDoc (xml);

  xsltCleanupGlobals ();
  xmlCleanupParser ();
}


int
main (int argc, char *argv[])
{

  if (argc < 2)
    {
      fprintf (stderr, "Realizeaza transformari XSLT via libxslt.\n"
	       "Sintaxa: %s <fisier.xml> <fisier.xsl>\n", argv[0]);
      return (1);
    }

  transforma_xml (argv[1], argv[2]);
  return (0);
}
