<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" omit-xml-declaration="yes" 
indent="yes" media-type="text/html" />

<xsl:template match="/">
   <xsl:apply-templates />
</xsl:template>

<!-- sablonul pentru afisare a cartilor -->
<xsl:template match="penguins">
  <table summary="Lista pinguinilor tineri" style="width: 500px;">
  <tr><th>Nume de pinguin</th><th>Varsta</th></tr>
  
  <xsl:for-each select="penguin">
    <!-- sortam dupa varsta, apoi dupa nume -->
    <xsl:sort select="age" />
    <xsl:sort select="name" /> 
    <tr style="text-align: center;">
      <td style="border: solid 1px gray; width: 430px;">
        <xsl:value-of select="name" />
      </td>
      <td style="border: solid 1px gray; width: 70px;">
        <xsl:value-of select="age" />
      </td>
    </tr>
  </xsl:for-each>

  </table>
  
  <p>Un total de <xsl:value-of select="count(penguin)" /> pinguini tineri.</p>
</xsl:template>

</xsl:stylesheet>