<?xml version="1.0" encoding="utf-8"?>
<!-- Foaie de stiluri utilizata pentru a genera 'stiri' RSS privitoare 
     la punctajele unor studenti.
     
     Autor: Sabin Corneliu Buraga 
     2007, 2009 - http://www.purl.org/net/busaco
     Ultima actualizare: 24 ianuarie 2009
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:output method="xml" indent="yes"/>

   <!-- URL-ul spre care conduce stirea -->
   <xsl:variable name="url">http://www.info.uaic.ro/~busaco/teach/courses/web/</xsl:variable>
   <!-- Informatii despre editorul stirii -->
   <xsl:variable name="editor">Sabin Buraga</xsl:variable>
   
   <xsl:template match="/">
      <!-- generam structura de baza a fisierului RSS -->
      <rss version="2.0">
         <channel>
            <title>Noutati privitoare la punctajele studentilor</title>
            <link><xsl:value-of select="$url"/></link>
            <description>Ultimele noutati privitoare la punctajele unor studenti
               la <xsl:value-of select="/punctaje/@exam"/>.</description>
            <language>ro</language>
            <!-- data publicarii ar putea fi generata dinamic (tema :)) -->
            <pubDate>04/18/09</pubDate>
            <managingEditor><xsl:value-of select="$editor"/></managingEditor>
            <webMaster><xsl:value-of select="$editor"/></webMaster>
         </channel>
         <xsl:apply-templates/>
      </rss>
   </xsl:template>

   <!-- generam cite o stire pentru fiecare student -->
   <xsl:template match="punctaje">
      <xsl:variable name="obiect" select="/punctaje/@exam"/>
      <xsl:for-each select="punctaj">
         <item>
            <title>Mare stire: <xsl:value-of select="@stud"/> a luat
                  <xsl:value-of select="nota[@tip = 'proiect']"/> la proiect! </title>
            <description><xsl:value-of select="@stud"/> a luat <xsl:value-of
                  select="nota[@tip = 'proiect']"/> puncte la proiectul de la
                  <xsl:value-of select="$obiect"/>. </description>
            <link><xsl:value-of select="$url"/></link>
         </item>
      </xsl:for-each>
   </xsl:template>

</xsl:stylesheet>
