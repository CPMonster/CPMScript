<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       Utils
    Module:     unixpath.xsl
    Usage:      Guts    
    Func:       Parsing and assembling Unix paths
-->    
<!-- * * ** *** ***** ******** ************* ********************* -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cpm="http://cpmonster.com/xmlns/cpm"
    exclude-result-prefixes="cpm xs"
    version="2.0">
    
    <!-- 
        Modules
    -->
    
    <!-- Working with URIs -->
    <xsl:import href="uri.xsl"/>
    
    <!-- Encodings -->
    <xsl:import href="../encoding.xsl"/>
    
    
    <!--  
        Converting a Windows path to an URI
    -->
    <xsl:template match="*[lower-case(@os) = ('mac', 'linux', 'unix')]" mode="cpm.path.2uri"> </xsl:template>
    
    
    <!--
        Converting an URI to a Unix path
    -->
    <xsl:template match="*[lower-case(@os) = ('mac', 'linux', 'unix')]" mode="cpm.uri.2path"> </xsl:template>
          
    
</xsl:stylesheet>