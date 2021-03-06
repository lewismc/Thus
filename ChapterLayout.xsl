<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:my="http://www.sbsa.gov.uk/XMLSYS/Handbook#1"
                xmlns:std="http://www.concept.co.uk/std"
                xmlns:fox="http://xml.apache.org/fop/extensions"
                >

  <xsl:output method="xml" version="1.0" encoding="UTF-8" standalone="yes" indent="yes"/>

  <xsl:include href="STD.xsl" />
  <xsl:include href="ChapterTypes.xsl" />
  <xsl:include href="ChapterFonts.xsl" />
  <xsl:include href="ChapterTOC.xsl" />
  <xsl:include href="ChapterFunctionalStandard.xsl" />
  <xsl:include href="ChapterRegulation.xsl" />
  <xsl:include href="ChapterParagraph.xsl" />
  <xsl:include href="ChapterList.xsl" />
  <xsl:include href="ChapterGraphic.xsl" />
  <xsl:include href="ChapterTable.xsl" />

  <!--

    Page Dimensions & Layout Variables

  -->
  
  <!-- Page Size A4 -->
  <xsl:variable name="page-width" select="'21cm'" />
  <xsl:variable name="page-height" select="'29.7cm'" />
  <xsl:variable name="chapter-marginref-area-width" select="'4.2cm'" />
  <xsl:variable name="chapter-text-area-width" select="'13.3cm'" />
  <xsl:variable name="chapter-text-area-sub-width" select="'6.4cm'" />
  <xsl:variable name="chapter-text-area-sub-width-wide" select="'8.5cm'" />
  <xsl:variable name="chapter-text-side-by-side-spacer" select="'0.5cm'" />
  <xsl:variable name="chapter-page-sbs-content-width" select="'10.6cm'" />
  <xsl:variable name="chapter-page-content-width" select="'17.5cm'" />
  <xsl:variable name="chapter-page-content-height" select="'24.2cm'" />
  
  
  <!-- Element Spacing -->
  <xsl:variable name="space-between-clauses" select="'11pt'" />
  <xsl:variable name="space-between-paragraph" select="'11pt'" />
  <xsl:variable name="space-between-paragraphs" select="'11pt'" />
  
  <!-- Document Info -->
  <xsl:variable name="document-format" select="/my:Document/my:Handbook/my:Section/my:Chapter/@formatStyle" />
  
  <!-- Page Output -->
  
  <xsl:template match="/my:Document/my:Handbook/my:Section" >
  
  <xsl:comment>
  Generated by ChapterLayout.xsl [THUS XML System - Release 1.3.0] (c) 2006 SBSA
  </xsl:comment> 
    
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" >
    
      <fo:layout-master-set>
      
        <fo:simple-page-master  master-name="blank.page"
                                page-width="{$page-width}" 
                                page-height="{$page-height}" >
          <fo:region-body />
        </fo:simple-page-master>
        
        <fo:simple-page-master  master-name="toc.page" 
                                page-width="{$page-width}" 
                                page-height="{$page-height}" 
                                margin-left="2.3cm"
                                margin-right="2.3cm" >
          <fo:region-before extent="3cm" precedence="true" />
          <fo:region-start extent="3.1cm" />
          <fo:region-body margin-top="3cm" margin-bottom="2.5cm" margin-left="3.1cm" />
          <fo:region-after extent="2.5cm" region-name="footer.toc" precedence="true" />
        </fo:simple-page-master>
        
        <fo:simple-page-master  master-name="text.page.even" 
                                page-width="{$page-width}" 
                                page-height="{$page-height}" 
                                margin-left="1.2cm"
                                margin-right="2.3cm" >
          <fo:region-before extent="2.4cm" precedence="true" />
          <fo:region-body margin-top="2.4cm" margin-bottom="2.5cm" />
          <fo:region-after extent="2.5cm" region-name="footer.even" precedence="true" />
        </fo:simple-page-master>
        
        <fo:simple-page-master  master-name="text.page.odd" 
                                page-width="{$page-width}" 
                                page-height="{$page-height}" 
                                margin-left="2.3cm"
                                margin-right="1.2cm" >
          <fo:region-before extent="2.4cm" precedence="true" />
          <fo:region-body margin-top="2.4cm" margin-bottom="2.5cm" />
          <fo:region-after extent="2.5cm" region-name="footer.odd" precedence="true" />
        </fo:simple-page-master>
        
        <fo:page-sequence-master master-name="text.page">
          <fo:repeatable-page-master-alternatives>
            <fo:conditional-page-master-reference odd-or-even="even" master-reference="text.page.even"/>
            <fo:conditional-page-master-reference odd-or-even="odd" master-reference="text.page.odd"/>
          </fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>
        
      </fo:layout-master-set>
      
      <xsl:apply-templates select="my:Chapter" />

    </fo:root>
    
  </xsl:template>

  <xsl:template name="PageHeader" >
    <fo:static-content flow-name="xsl-region-before">
      <fo:table border-collapse="collapse" table-layout="fixed" inline-progression-dimension.minimum="100%" >
        <fo:table-column column-number="1" width="100%" />
        <fo:table-body>
          <fo:table-row height="1.6cm" display-align="after" >
            <fo:table-cell>
              <fo:block text-align="start" xsl:use-attribute-sets="PageHeaderFont" >
                <xsl:apply-templates select="/my:Document/my:Handbook" mode="TYPE" />
                <xsl:text> | </xsl:text>
                <xsl:call-template name="std:ToLower" >
                  <xsl:with-param name="text" select="/my:Document/my:Handbook/my:Section/my:SectionTitle" />
                </xsl:call-template>
                <xsl:text> | </xsl:text>
                <xsl:if test="/my:Document/my:Handbook/my:Section/my:Chapter/@chapterType = $chapter-type-annex" >
                  <xsl:text>annex </xsl:text>
                  <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
                  <xsl:text>.</xsl:text>
                  <xsl:call-template name="std:ToUpper" >
                    <xsl:with-param name="text" select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterNo" />
                  </xsl:call-template>
                  <xsl:text> | </xsl:text>
                </xsl:if>
                <xsl:choose>
                  <xsl:when test="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterTitle[not(text())]" >
                    <fo:inline color="red">Missing chapter title</fo:inline>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:call-template name="std:ToLower" >
                      <xsl:with-param name="text" select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterTitle" />
                    </xsl:call-template>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:text> | </xsl:text>
                <xsl:apply-templates select="/my:Document/my:Handbook" mode="YEAR" />
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:static-content>
  </xsl:template>
  
  <xsl:template match="my:Handbook" mode="TYPE" >
    <xsl:choose>
      <xsl:when test="@handbookType = $handbook-type-domestic" >domestic</xsl:when>
      <xsl:when test="@handbookType = $handbook-type-non-domestic" >non-domestic</xsl:when>
      <xsl:otherwise>
        <fo:inline color="red">unknown</fo:inline>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="my:Handbook" mode="YEAR" >
    <xsl:value-of select="@year" />
  </xsl:template>
  
  
  <xsl:template match="my:Chapter" >
    <!-- Bookmark -->
    <fox:outline>
      <xsl:attribute name="internal-destination">
        <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterNo" />
        <xsl:text> </xsl:text>
        <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterTitle" />
      </xsl:attribute>
      <fox:label>
        <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterNo" />
        <xsl:text> </xsl:text>
        <xsl:value-of select="normalize-space( /my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterTitle )" />
      </fox:label>
      <xsl:for-each select="my:Clause" >
        <fox:outline>
          <xsl:attribute name="internal-destination">
            <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
            <xsl:text>.</xsl:text>
            <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterNo" />
            <xsl:text>.</xsl:text>
            <xsl:value-of select="my:ClauseNo" />
            <xsl:text> </xsl:text>
            <xsl:value-of select="my:ClauseTitle" />
          </xsl:attribute>
          <fox:label>
            <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
            <xsl:text>.</xsl:text>
            <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterNo" />
            <xsl:text>.</xsl:text>
            <xsl:value-of select="my:ClauseNo" />
            <xsl:text> </xsl:text>
            <xsl:value-of select="normalize-space( my:ClauseTitle )" />
          </fox:label>
        </fox:outline>
      </xsl:for-each>
    </fox:outline>
    
    <xsl:call-template name="ChapterTOC" >
      <xsl:with-param name="chapter" select="." />
    </xsl:call-template>
    
    <fo:page-sequence master-reference="text.page" >

        <!-- Page Header -->
        <xsl:call-template name="PageHeader" />

        <!-- Page Footer for Odd Pages -->
        <fo:static-content flow-name="footer.odd" display-align="after">
          <fo:table border-collapse="collapse" table-layout="fixed" inline-progression-dimension.minimum="100%" >
            <fo:table-column column-number="1" width="100%" />
            <fo:table-body>
              <fo:table-row height="1.3cm" display-align="after" >
                <fo:table-cell>
                  <fo:block xsl:use-attribute-sets="PageFooterFont" text-align="end" >
                    <fo:inline>
                      <fo:retrieve-marker retrieve-class-name="clause-begin" 
                                          retrieve-position="first-starting-within-page" />
                    </fo:inline>
                    <fo:inline font-size="10pt"><xsl:text> </xsl:text>&#x2014;<xsl:text> </xsl:text></fo:inline>
                    <fo:inline>
                      <fo:retrieve-marker retrieve-class-name="clause-end" 
                                          retrieve-position="last-starting-within-page" />
                    </fo:inline>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </fo:static-content>
        
        <!-- Page Footer for Even Pages -->
        <fo:static-content flow-name="footer.even" display-align="after">
          <fo:table border-collapse="collapse" table-layout="fixed" inline-progression-dimension.minimum="100%" >
            <fo:table-column column-number="1" width="100%" />
            <fo:table-body>
              <fo:table-row height="1.3cm" display-align="after" >
                <fo:table-cell>
                  <fo:block xsl:use-attribute-sets="PageFooterFont" text-align="start" >
                    <fo:inline>
                      <fo:retrieve-marker retrieve-class-name="clause-begin" 
                                          retrieve-position="first-starting-within-page" />
                    </fo:inline>
                    <fo:inline font-size="10pt"><xsl:text> </xsl:text>&#x2014;<xsl:text> </xsl:text></fo:inline>
                    <fo:inline>
                      <fo:retrieve-marker retrieve-class-name="clause-end" 
                                          retrieve-position="last-starting-within-page" />
                    </fo:inline>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </fo:static-content>

        <!-- Page Body -->
        <fo:flow flow-name="xsl-region-body">
        
          <xsl:if test="@chapterType = $chapter-type-introduction and $document-format = $document-format-normal" >
            <fo:list-block>
              <fo:list-item>
                <fo:list-item-label>
                  <fo:block>
                    <fo:block xsl:use-attribute-sets="LogoNormalFont">
                      <xsl:value-of select="my:ChapterTitle" />
                    </fo:block>
                    <fo:block xsl:use-attribute-sets="LogoLargeFont">
                      <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
                      <xsl:text>.</xsl:text>
                      <xsl:value-of select="my:ChapterNo" />
                    </fo:block>
                  </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                  <fo:block />
                </fo:list-item-body>
              </fo:list-item>
            </fo:list-block>
          </xsl:if>
          
          <xsl:if test="@chapterType = $chapter-type-functional-standard" >
            <fo:block xsl:use-attribute-sets="PageFooterFont">
              <fo:marker marker-class-name="clause-begin">
                <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
                <xsl:text>.</xsl:text>
                <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterNo" />
              </fo:marker>
            </fo:block>
            <xsl:apply-templates select="my:FunctionalStandard" />
          </xsl:if>
          
          <xsl:if test="@chapterType = $chapter-type-regulation" >
            <xsl:apply-templates select="my:Regulation" />
          </xsl:if>

          <xsl:if test="@chapterType = $chapter-type-annex and $document-format = $document-format-normal" >
            <fo:list-block>
              <fo:list-item>
                <fo:list-item-label>
                  <fo:block>
                    <fo:block xsl:use-attribute-sets="LogoNormalFont">
                      <xsl:text>annex</xsl:text>
                    </fo:block>
                    <fo:block xsl:use-attribute-sets="LogoLargeFont">
                      <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
                      <xsl:text>.</xsl:text>
                      <xsl:value-of select="my:ChapterNo" />
                    </fo:block>
                  </fo:block>
                </fo:list-item-label>
                <fo:list-item-body>
                  <fo:block />
                </fo:list-item-body>
              </fo:list-item>
            </fo:list-block>
          </xsl:if>
          
          <xsl:apply-templates select="my:Clause" />
        </fo:flow>
        
      </fo:page-sequence>
    
  </xsl:template>
  
  <xsl:template name="ClauseTitle" >
  
    <xsl:param name="clause" />
    
    <fo:block xsl:use-attribute-sets="ClauseTitleFont">
      <xsl:attribute name="id">
        <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterNo" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="my:ClauseNo" />
        <xsl:text> </xsl:text>
        <xsl:value-of select="$clause/my:ClauseTitle" />
      </xsl:attribute>
      <fo:inline>
        <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterNo" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="my:ClauseNo" />
      </fo:inline>
      <fo:leader leader-length="0.5cm" />
      <fo:inline>
        <xsl:choose>
          <xsl:when test="string-length( normalize-space( $clause/my:ClauseTitle ) ) = 0" >
            <fo:inline color="red">Missing clause title.</fo:inline>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="$clause/my:ClauseTitle" />
          </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="$clause/my:ClauseSubTitle" />
      </fo:inline>
    </fo:block>

  </xsl:template>

  <xsl:template match="my:ClauseSubTitle" >
    <fo:block>
      <xsl:choose>
        <xsl:when test="string-length( normalize-space( . ) ) = 0">
          <fo:inline color="red">Missing clause sub-title.</fo:inline>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates />
        </xsl:otherwise>
      </xsl:choose>
    </fo:block>
  </xsl:template>
  

  <xsl:template match="my:Clause" >
   
    <fo:block xsl:use-attribute-sets="PageFooterFont">
      <fo:marker marker-class-name="clause-begin">
        <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterNo" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="my:ClauseNo" />
      </fo:marker>
      <fo:marker marker-class-name="clause-end">
        <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterNo" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="my:ClauseNo" />
      </fo:marker>
    </fo:block>
   
    <fo:table table-layout="fixed" inline-progression-dimension.minimum="100%" >
      <xsl:attribute name="role">      
        <xsl:value-of select="concat('my:', local-name())"/>
      </xsl:attribute>
      <fo:table-column column-number="1" column-width="{$chapter-marginref-area-width}" />
      <fo:table-column column-number="2" column-width="{$chapter-text-area-width}" />
      <fo:table-body>
        <fo:table-row keep-with-next="always">
          <xsl:choose>
            <xsl:when test="$document-format = $document-format-normal">
              <fo:table-cell><fo:block /></fo:table-cell>
              <fo:table-cell>
                <xsl:call-template name="ClauseTitle" >
                  <xsl:with-param name="clause" select="." />
                </xsl:call-template>
              </fo:table-cell>
            </xsl:when>
            <xsl:otherwise>
              <fo:table-cell number-columns-spanned="2">
                <xsl:call-template name="ClauseTitle" >
                  <xsl:with-param name="clause" select="." />
                </xsl:call-template>
              </fo:table-cell>
            </xsl:otherwise>
          </xsl:choose>
        </fo:table-row>
      </fo:table-body>
    </fo:table>

    <xsl:apply-templates select="my:ClauseContent" />

    
  </xsl:template>
  
  <xsl:template match="my:ClauseContent" >
  
    <xsl:apply-templates mode="prepare-element" />

  </xsl:template>
  
  <xsl:template match="my:ClauseContent/*" mode="prepare-element" >
  
    <!-- Are we going side-by-side with current element and next element? -->
    <xsl:variable name="side-by-side-leader" select="
                                                      @bindNext = 'true'
                                                      and
                                                      ( following-sibling::*[1] )[@bindable = 'true' and not( @bindNext = 'true' )]
                                                      and
                                                      not( following-sibling::*[1][@tableType = $table-format-wide 
                                                           or 
                                                           @graphicType = $graphic-format-wide] )
                                                     " />

    <!-- Are we going side-by-side with previous element? (i.e. current element has already been consumed) -->
    <xsl:variable name="side-by-side-follower" select="
                                                        @bindable = 'true' 
                                                        and
                                                        ( preceding-sibling::*[1] )[@bindNext = 'true']
                                                        and
                                                        not( @bindNext = 'true' )
                                                        and
                                                        not( @tableType = $table-format-wide or @graphicType = $graphic-format-wide )
                                                      " />
    <!-- Are we normal content output? -->
    <xsl:variable name="content" select="$side-by-side-leader = 'false' and $side-by-side-follower = 'false'" />
    
    <!-- FOP 0.20.5 apparently does not honour the XSL-FO specification regarding 'space-before' and 'space-after'
         attributes. It does not collapse redundant space at the start/end of pages as it should therefore
         causing paragraphs and clauses to invisibly bleed onto the next page. This causes unwanted white
         space at the top of pages where a page break has coincided with the end of an element. 
         -->
    <xsl:if test="self::my:PageBreak and @applyBreak = 'true'" >
      <fo:block break-after="page" role="ForcedPageBreak" />
    </xsl:if>
         
    <xsl:if test="self::my:PageBreak and @applyBreak = 'false'" >
      <xsl:if test="following-sibling::* 
                    and not( local-name( following-sibling::*[1] ) = 'List' )
                    and not( local-name( following-sibling::*[1] ) = 'PageBreak' )
                    " >
        <fo:block space-before="9pt" role="ParagraphSpacer" />
      </xsl:if>
    </xsl:if>

    <xsl:if test="not( self::my:PageBreak )" >
      <xsl:if test="not( $side-by-side-follower = 'true' )" >
        <fo:table table-layout="fixed" inline-progression-dimension.minimum="100%" >
          <xsl:attribute name="role">      
            <xsl:value-of select="concat( local-name(), '-Container' )"/>
          </xsl:attribute>
          <xsl:if test="$side-by-side-leader = 'true'">
            <fo:table-column>
              <xsl:attribute name="column-width" >
                <xsl:choose>
                  <xsl:when test="@bindNextWidth &gt; 0">
                    <xsl:value-of select="@bindNextWidth" />cm
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:choose>
                      <xsl:when test="$document-format = $document-format-normal">
                        <xsl:value-of select="$chapter-page-sbs-content-width" />                    
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$chapter-text-area-sub-width-wide" />                    
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
            </fo:table-column>
            <fo:table-column column-width="{$chapter-text-side-by-side-spacer}" />
          </xsl:if>
          <fo:table-column column-width="100%" />
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell>
                <xsl:attribute name="role">  
                  <xsl:choose>
                    <xsl:when test="$side-by-side-leader = 'true'">
                      <xsl:value-of select="concat( local-name(), '-Content-Leader' )"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="concat( local-name(), '-Content' )"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:apply-templates select="." />
              </fo:table-cell>
              <xsl:if test="$side-by-side-leader = 'true'" >
                <fo:table-cell><fo:block /></fo:table-cell>
                <fo:table-cell>
                  <xsl:attribute name="role">
                      <xsl:value-of select="concat( local-name(), '-Content-Follower' )"/>
                  </xsl:attribute>
                  <xsl:apply-templates select="following-sibling::*[1]" mode="in-cell" />
                </fo:table-cell>
              </xsl:if>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
        <xsl:if test="following-sibling::* 
                      and not( local-name( following-sibling::*[1] ) = 'List' )
                      and not( local-name( following-sibling::*[1] ) = 'PageBreak' )
                      " >
          <fo:block space-before="9pt" role="ParagraphSpacer" />
                     <!-- and not( ( following-sibling::*[1] )[@applyBreak = 'true' ] ) -->
          
        </xsl:if>
      </xsl:if>
    </xsl:if>
    
    <xsl:if test="not( self::my:PageBreak and @applyBreak = 'true' )" >
      <fo:block xsl:use-attribute-sets="PageFooterFont" >
        <fo:marker marker-class-name="clause-begin">
          <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
          <xsl:text>.</xsl:text>
          <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterNo" />
          <xsl:text>.</xsl:text>
          <xsl:value-of select="../../my:ClauseNo" />
        </fo:marker>
        <fo:marker marker-class-name="clause-end">
          <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:SectionNo" />
          <xsl:text>.</xsl:text>
          <xsl:value-of select="/my:Document/my:Handbook/my:Section/my:Chapter/my:ChapterNo" />
          <xsl:text>.</xsl:text>
          <xsl:value-of select="../../my:ClauseNo" />
        </fo:marker>
      </fo:block>
    </xsl:if>
    
    <xsl:if test="not( following-sibling::* ) and not( self::my:PageBreak and @applyBreak = 'true' )" >
      <fo:block space-before="9pt" role="ParagraphSpacer" />
    </xsl:if>
    
  </xsl:template>
  
  <xsl:template match="my:MarginReference" >
    <fo:block xsl:use-attribute-sets="MarginRefFont" role="MarginReference" padding-top="1.5pt">
      <xsl:choose>
        <xsl:when test="string-length( normalize-space( . ) ) = 0">
          <fo:inline color="red">Missing margin reference.</fo:inline>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="@marginReferenceType = $margin-reference-type-url">
              <fo:inline color="blue" text-decoration="underline" role="URL">
                <fo:basic-link external-destination="http://{.}" >
                  <xsl:call-template name="std:URL" >
                    <xsl:with-param name="url" select="." />
                  </xsl:call-template>
                </fo:basic-link>
              </fo:inline>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </fo:block>
  </xsl:template>
  
</xsl:stylesheet>
