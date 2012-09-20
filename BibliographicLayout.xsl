<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:my="http://www.sbsa.gov.uk/XMLSYS/Handbook#1"
                xmlns:std="http://www.concept.co.uk/std"
                xmlns:html="http://www.w3.org/1999/xhtml" 
                xmlns:fox="http://xml.apache.org/fop/extensions"
                >

  <xsl:output method="xml" version="1.0" encoding="UTF-8" standalone="yes" indent="yes"/>

  <xsl:include href="STD.xsl" />
  <xsl:include href="BibliographicTypes.xsl" />
  <xsl:include href="BibliographicFonts.xsl" />
  <xsl:include href="BiblioTableSizes.xsl" />
  <xsl:include href="BiblioBritishStandards.xsl" />
  <xsl:include href="BiblioCodesOfPractice.xsl" />
  <xsl:include href="BiblioEuropeanStandards.xsl" />
  <xsl:include href="BiblioDrafts.xsl" />
  <xsl:include href="BiblioLegislation.xsl" />
  <xsl:include href="BiblioOtherPublications.xsl" />

  <xsl:attribute-set name="i">
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="em">
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="b">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="strong">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="strong-em">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>

  <!--

    Page Dimensions & Layout Variables

  -->
  
  <!-- Page Size A4 -->
  <xsl:variable name="page-width" select="'21cm'" />
  <xsl:variable name="page-height" select="'29.7cm'" />
  
  <!-- Page Output -->
  
  <xsl:template match="/my:BG_Appendix" >
  
    <xsl:comment>Generated by BibliographicLayout.xsl [THUS XML System - Release 1.2.0]</xsl:comment> 
    
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" >
    
      <fo:layout-master-set>
      
        <fo:simple-page-master  master-name="text.page.even" 
                                page-width="{$page-width}" 
                                page-height="{$page-height}" 
                                margin-left="1.2cm"
                                margin-right="2.3cm" >
          <fo:region-before extent="3cm" precedence="true" />
          <fo:region-body margin-top="3cm" margin-bottom="2.5cm" />
          <fo:region-after extent="2.5cm" region-name="footer.even" precedence="true" />
        </fo:simple-page-master>
        
        <fo:simple-page-master  master-name="text.page.odd" 
                                page-width="{$page-width}" 
                                page-height="{$page-height}" 
                                margin-left="2.3cm"
                                margin-right="1.2cm" >
          <fo:region-before extent="3cm" precedence="true" />
          <fo:region-body margin-top="3cm" margin-bottom="2.5cm" />
          <fo:region-after extent="2.5cm" region-name="footer.odd" precedence="true" />
        </fo:simple-page-master>
        
        <fo:page-sequence-master master-name="text.page">
          <fo:repeatable-page-master-alternatives>
            <fo:conditional-page-master-reference odd-or-even="even" master-reference="text.page.even"/>
            <fo:conditional-page-master-reference odd-or-even="odd" master-reference="text.page.odd"/>
          </fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>
        
      </fo:layout-master-set>
      
    <!-- Bookmark -->
    <fox:outline internal-destination="AppendixB">
      <fox:label>Appendix B list of standards and other publications</fox:label>
    </fox:outline>
      
    <fo:page-sequence master-reference="text.page" >

        <!-- Page Header -->
        <fo:static-content flow-name="xsl-region-before">
          <fo:table border-collapse="collapse" table-layout="fixed" inline-progression-dimension.minimum="100%" >
            <fo:table-column column-number="1" width="100%" />
            <fo:table-body>
              <fo:table-row height="1.6cm" display-align="after" >
                <fo:table-cell>
                  <fo:block text-align="start" xsl:use-attribute-sets="PageHeaderFont" >
                    <xsl:apply-templates select="/my:BG_Appendix" mode="TYPE" />
                    <xsl:text> | appendix b | list of standards and other publications | </xsl:text>
                    <xsl:apply-templates select="/my:BG_Appendix" mode="YEAR" />
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </fo:static-content>

        <!-- Page Body -->
        <fo:flow flow-name="xsl-region-body">
        
          <xsl:apply-templates/>
        
        </fo:flow>
        
      </fo:page-sequence>

    </fo:root>
    
  </xsl:template>

  <xsl:template match="my:BG_Appendix" mode="TYPE" >
    <xsl:choose>
      <xsl:when test="@handbookType = $handbook-type-domestic" >domestic</xsl:when>
      <xsl:when test="@handbookType = $handbook-type-non-domestic" >non-domestic</xsl:when>
      <xsl:otherwise>
        <fo:inline color="red">unknown</fo:inline>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="my:BG_Appendix" mode="YEAR" >
    <xsl:value-of select="@year" />
  </xsl:template>
  
  
  <xsl:template match="my:BG_AppendixPrologue" >
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="my:BG_AppendixCaption" >
    <fo:block xsl:use-attribute-sets="CaptionFont" id="AppendixB">
      <xsl:choose>
        <xsl:when test="string-length( normalize-space( . ) ) = 0">
          <fo:inline color="red">Missing Caption.</fo:inline>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="." />
        </xsl:otherwise>
      </xsl:choose>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="my:BG_AppendixLeader" >
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="my:BG_AppendixNotes" >
    <fo:list-block space-before="11pt" provisional-distance-between-starts="1.5cm">
      <xsl:apply-templates select="my:BG_AppendixNoteItem" />
    </fo:list-block>
  </xsl:template>
  
  <xsl:template match="my:BG_AppendixNoteItem" >
    <fo:list-item>
      <fo:list-item-label end-indent="label-end()">
        <fo:block xsl:use-attribute-sets="PrologueNoteItemFont">Note<xsl:text> </xsl:text><xsl:number format="1" />.</fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()">
        <fo:block xsl:use-attribute-sets="PrologueNoteItemFont" >
          <xsl:choose>
            <xsl:when test="string-length( normalize-space( . ) ) = 0">
              <fo:inline color="red">Missing Item.</fo:inline>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="." />
            </xsl:otherwise>
          </xsl:choose>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>
  
  <xsl:template match="my:BG_ParagraphText" >
    <fo:block xsl:use-attribute-sets="LeaderFont" space-before="11pt">
      <xsl:choose>
        <xsl:when test="string-length( normalize-space( . ) ) = 0">
          <fo:inline color="red">Missing Text.</fo:inline>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates />
        </xsl:otherwise>
      </xsl:choose>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="my:BG_AppendixContent" >
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="html:i">
    <fo:inline xsl:use-attribute-sets="i">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:em">
    <fo:inline xsl:use-attribute-sets="em">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:b">
    <fo:inline xsl:use-attribute-sets="b">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:strong">
    <fo:inline xsl:use-attribute-sets="strong">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:strong//html:em | html:em//html:strong">
    <fo:inline xsl:use-attribute-sets="strong-em">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>

</xsl:stylesheet>
