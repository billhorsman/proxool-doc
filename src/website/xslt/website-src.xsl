<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    <xsl:output method="xml" indent="yes" />

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="article | book">
        <webpage id="{normalize-space(concat(//title,' ',//subtitle))}">
            <xsl:apply-templates/>
        </webpage>
    </xsl:template>

    <xsl:template match="articleinfo | bookinfo">
        <head>
            <xsl:copy-of select="title"/>
            <summary><xsl:copy-of select="abstract/*"/></summary>
        </head>
    </xsl:template>

    <xsl:template match="*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="text()">
        <xsl:copy/>
    </xsl:template>


</xsl:stylesheet>