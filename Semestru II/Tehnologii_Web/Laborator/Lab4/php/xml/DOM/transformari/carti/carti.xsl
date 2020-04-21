<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" omit-xml-declaration="yes" 
indent="yes" media-type="text/html" />

<xsl:template match="/">
   <xsl:apply-templates />
</xsl:template>

<!-- sablonul pentru afisare a cartilor -->
<xsl:template match="carti">
  <table summary="Lista cartilor">
  <tr><th>Titlu</th><th>Autor</th><th>Format</th></tr>
  
  <xsl:for-each select="carte">
    <!-- sortam dupa colectie si autor -->
    <xsl:sort select="colectie" order="descending" />
    <xsl:sort select="autor" />
    <tr>
      <td><xsl:value-of select="autor" /></td>
      <td><xsl:value-of select="titlu" /></td>
      <td><xsl:value-of select="colectie" /></td>
    </tr>
  </xsl:for-each>

  </table>
</xsl:template>

</xsl:stylesheet>