<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  version='1.0'>

  <xsl:import href="../../../build/website-2.5.0/xsl/chunk-tabular.xsl"/>

  <!-- Replace the text in these templates with whatever you want -->
  <!-- to appear in the respective location on the home page. -->

  <xsl:param name="navbgcolor">white</xsl:param>

  <xsl:template name="home.navhead">
    <span class="titleCaption">
      Proxool 0.8.3
    </span>
  </xsl:template>

  <xsl:template name="home.navhead.upperright">
    <img src="webimages/dots.gif" width="80" height="20" border="0" alt="..."/>
    <a href="http://sourceforge.net/projects/proxool"><img src="http://sourceforge.net/sflogo.php?group_id=proxool&amp;type=1" width="88" height="31" border="0" alt="SourceForge.net Logo"/></a>
  </xsl:template>

  <xsl:template name="home.navhead.separator"/>

  <!-- put your customizations here -->

  <!-- A customised webpage template -->
  <xsl:template match="webpage">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <xsl:variable name="relpath">
      <xsl:call-template name="root-rel-path">
        <xsl:with-param name="webpage" select="."/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="filename">
      <xsl:apply-templates select="." mode="filename"/>
    </xsl:variable>

    <xsl:variable name="tocentry" select="$autolayout/autolayout//*[$id=@id]"/>
    <xsl:variable name="toc" select="($tocentry/ancestor-or-self::toc
    |$autolayout/autolayout/toc[1])[last()]"/>

    <html>
      <xsl:apply-templates select="head" mode="head.mode"/>
      <xsl:apply-templates select="config" mode="head.mode"/>
      <body class="tabular">
        <xsl:call-template name="body.attributes"/>

        <div class="{name(.)}">
          <a name="{$id}"/>

          <xsl:call-template name="allpages.banner"/>

          <table xsl:use-attribute-sets="table.properties" border="0">
            <xsl:if test="$nav.table.summary!=''">
              <xsl:attribute name="summary">
                <xsl:value-of select="$nav.table.summary"/>
              </xsl:attribute>
            </xsl:if>
            <tr>
              <td><img src="{$table.spacer.image}" alt=" " width="1" height="1"/></td>
              <xsl:call-template name="hspacer"/>
              <td rowspan="2" xsl:use-attribute-sets="table.body.cell.properties">
                <xsl:if test="$navbodywidth != ''">
                  <xsl:attribute name="width">
                    <xsl:value-of select="$navbodywidth"/>
                  </xsl:attribute>
                </xsl:if>

                <xsl:if test="$autolayout/autolayout/toc[1]/@id = $id">
                  <table border="0" summary="home page extra headers"
                    cellpadding="0" cellspacing="0" width="100%">
                    <!-- proxool-blue row-->
                    <tr bgcolor="#99ccff">
                      <xsl:call-template name="home.navhead.cell"/>
                      <xsl:call-template name="home.navhead.upperright.cell"/>
                    </tr>
                  </table>
                  <xsl:call-template name="home.navhead.separator"/>
                </xsl:if>

                <xsl:if test="$autolayout/autolayout/toc[1]/@id != $id
                or $suppress.homepage.title = 0">
                  <xsl:apply-templates select="./head/title" mode="title.mode"/>
                </xsl:if>

                <xsl:apply-templates select="child::*[name(.) != 'webpage']"/>
                <xsl:call-template name="process.footnotes"/>
                <br/>
              </td>
            </tr>
            <tr>
              <td xsl:use-attribute-sets="table.navigation.cell.properties">
                <xsl:if test="$navtocwidth != ''">
                  <xsl:attribute name="width">
                    <xsl:choose>
                      <xsl:when test="/webpage/config[@param='navtocwidth']/@value[. != '']">
                        <xsl:value-of select="/webpage/config[@param='navtocwidth']/@value"/>
                      </xsl:when>
                      <xsl:when test="$autolayout/autolayout/config[@param='navtocwidth']/@value[. != '']">
                        <xsl:value-of select="$autolayout/autolayout/config[@param='navtocwidth']/@value"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$navtocwidth"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
                </xsl:if>
                <xsl:choose>
                  <xsl:when test="$toc">
                    <p class="navtoc">
                      <xsl:apply-templates select="$toc">
                        <xsl:with-param name="pageid" select="@id"/>
                      </xsl:apply-templates>
                    </p>
                  </xsl:when>
                  <xsl:otherwise>&#160;</xsl:otherwise>
                </xsl:choose>
              </td>
              <xsl:call-template name="hspacer"/>
            </tr>
            <xsl:call-template name="webpage.table.footer"/>
          </table>

          <xsl:call-template name="webpage.footer"/>
        </div>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
