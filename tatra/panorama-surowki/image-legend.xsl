<?xml version="1.0" encoding="UTF-8"?>
<!-- Author: Filip Zyzniewski <filip.zyzniewski@gmail.com> -->
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/2000/svg"
>
  <xsl:output
    method="xml"
    doctype-system="about:legacy-compat"
    omit-xml-declaration="yes"
    encoding="UTF-8"
    indent="yes"
  />

  <xsl:variable name="debug">false</xsl:variable>
  <xsl:variable name="text_offset">2</xsl:variable>

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="image">
    <svg
      xmlns="http://www.w3.org/2000/svg"
      xmlns:xlink="http://www.w3.org/1999/xlink"
      width="{@width}mm"
      height="{@height}mm"
      viewBox="0 0 {@width} {@height}"
    >
      <style>
        text {
          font-family: sans-serif;
          font-weight: bold;
          font-size: 0.6mm;
          fill: #202060;
          stroke: white;
          stroke-width: 0.02mm;
          stroke-miterlimit: 4;
        }
      </style>
      <xsl:apply-templates/>
    </svg>
  </xsl:template>
  
  <xsl:template match="background">
    <image xlink:href="{@href}" x="0" y="0" width="{../@width}" height="{../@height}"/>
  </xsl:template>

  <xsl:template match="arc">
    <xsl:variable name="r">
      <xsl:choose>
        <xsl:when test="@r != ''"><xsl:value-of select="@r"/></xsl:when>
        <xsl:otherwise>30</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <a>
      <xsl:attribute name="href">
        https://pl.wikipedia.org/wiki/<xsl:choose>
          <xsl:when test="@wiki != ''"><xsl:value-of select="@wiki"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>  
      <xsl:if test="$debug = 'true'">
        <circle cx="{@x}" cy="{@y}" r="1" fill="none" stroke="red" stroke-width="0.2"/>
      </xsl:if>
      <text text-anchor="middle" transform="rotate({@angle}, {@x}, {@y})">
        <textPath path="M {@x - $r} {@y + $r - $text_offset} a {$r} {$r} 0 0 1 {$r * 2} 0" startOffset="50%">
          <tspan><xsl:value-of select="."/></tspan>
        </textPath>
      </text>
    </a>
  </xsl:template>
  
  <xsl:template match="line">
    <xsl:variable name="angle">
      <xsl:choose>
        <xsl:when test="@slant = 'left'">45</xsl:when>
        <xsl:when test="@slant = 'right'">-45</xsl:when>
        <xsl:when test="@slant != ''"><xsl:value-of select="@slant"/></xsl:when>
        <xsl:otherwise>90</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <a>
      <xsl:attribute name="href">
        https://pl.wikipedia.org/wiki/<xsl:choose>
          <xsl:when test="@wiki != ''"><xsl:value-of select="@wiki"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>  
      <xsl:if test="$debug = 'true'">
        <circle cx="{@x}" cy="{@y}" r="1" fill="none" stroke="red" stroke-width="0.2"/>
      </xsl:if>
      <text y="{@y + 0.5}" transform="rotate({$angle}, {@x}, {@y})">
        <xsl:choose>
          <xsl:when test="$angle > 0">
            <xsl:attribute name="text-anchor">end</xsl:attribute>
            <xsl:attribute name="x"><xsl:value-of select="@x - $text_offset"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="text-anchor">start</xsl:attribute>
            <xsl:attribute name="x"><xsl:value-of select="@x + $text_offset"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <tspan><xsl:value-of select="."/></tspan>
      </text>
    </a>
  </xsl:template>

</xsl:stylesheet>
