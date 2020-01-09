<?xml version="1.0" encoding="UTF-8"?>
<!-- * * ** *** ***** ******** ************* ********************* -->
<!--    
    Product:    CopyPaste Monster    
    Area:       Libraries    
    Part:       Utils
    Module:     parseury.xsl
    Usage:      Guts    
    Func:       Parsing and assembling paths and URIs
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
    
    <!-- Extra string functions -->
    <xsl:import href="../morestr.xsl"/>
    
    
    <!-- 
        Representing an URI as a sequence of named elements
    -->
    <xsl:function name="cpm:pathuri.parseURI">
        
        <xsl:param name="strURI"/>
        
        
        <!-- A protocol (mandatory for an URI) -->
        
        <xsl:variable name="strProtocol">
            <xsl:value-of select="substring-before($strURI, ':')"/>
        </xsl:variable>
        
        <xsl:variable name="strRemain1">
            <xsl:value-of select="substring-after($strURI, ':')"/>
        </xsl:variable>
        
        
        <!-- A host and a port -->
        
        <xsl:variable name="strHPRegexp">
            <xsl:text><![CDATA[^//([A-Za-z\.\-_\d]+)(:\d+)?]]></xsl:text>
        </xsl:variable>
        
        <xsl:variable name="strHP">
            <xsl:choose>
                <xsl:when test="matches($strRemain1, concat($strHPRegexp, '/'))">
                    <xsl:value-of select="cpm:morestr.afterBefore($strRemain1, '//', '/')"/>
                </xsl:when>
                <xsl:when test="matches($strRemain1, concat($strHPRegexp, '#'))">
                    <xsl:value-of select="cpm:morestr.afterBefore($strRemain1, '//', '#')"/>
                </xsl:when>
                <xsl:when test="matches($strRemain1, concat($strHPRegexp, '\?'))">
                    <xsl:value-of select="cpm:morestr.afterBefore($strRemain1, '//', '?')"/>
                </xsl:when>
                <xsl:when test="matches($strRemain1, concat($strHPRegexp, '$'))">
                    <xsl:value-of select="substring-after($strRemain1, '//')"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="strHost">
            <xsl:if test="$strHP != ''">
                <xsl:choose>
                    <xsl:when test="contains($strHP, ':')">
                        <xsl:value-of select="substring-before($strHP, ':')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$strHP"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:variable>
        
        <xsl:variable name="strPort">
            <xsl:if test="$strHP != '' and contains($strHP, ':')">
                <xsl:value-of select="substring-after($strHP, ':')"/>
            </xsl:if>
        </xsl:variable>
        
        <xsl:variable name="strRemain2">
            <xsl:choose>
                <xsl:when test="$strHP != ''">
                    <xsl:if test="not(matches($strRemain1, concat($strHPRegexp, '$')))">
                        <xsl:value-of select="substring($strRemain1, string-length($strHP) + 3)"/>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="starts-with($strRemain1, '///')">
                            <xsl:value-of select="substring-after($strRemain1, '///')"/>
                        </xsl:when>
                        <xsl:when test="starts-with($strRemain1, '/')">
                            <xsl:value-of select="substring-after($strRemain1, '/')"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        
        <!-- Drive, folders, and file -->
        
        <xsl:variable name="strRawLocalFile">
            <xsl:choose>
                <xsl:when test="contains($strRemain2, '?')">
                    <xsl:value-of select="substring-before($strRemain2, '?')"/>
                </xsl:when>
                <xsl:when test="contains($strRemain2, '#')">
                    <xsl:value-of select="substring-before($strRemain2, '#')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$strRemain2"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="strLocalFile" select="cpm:morestr.dockHead($strRawLocalFile, '/')"/>
        
        
        <!-- Drive -->
        
        <xsl:variable name="strDrive">
            <xsl:if test="contains($strLocalFile, ':')">
                <xsl:value-of select="substring-before($strLocalFile, ':')"/>
            </xsl:if>
        </xsl:variable>
        
        
        <!-- Folders and a file -->
        
        <xsl:variable name="strRawRemain3">
            <xsl:choose>
                <xsl:when test="contains($strLocalFile, ':')">
                    <xsl:value-of select="substring-after($strLocalFile, ':')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$strLocalFile"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="strRemain3">
            <xsl:value-of select="cpm:morestr.dockHead($strRawRemain3, '/')"/>
        </xsl:variable>
        
        <xsl:variable name="seqFiles" as="xs:string*">
            <xsl:copy-of select="tokenize($strRemain3, '/')"/>
        </xsl:variable>
        
        
        <!-- Parameters -->
        
        <xsl:variable name="seqParams" as="xs:string*">
            <xsl:if test="contains($strRemain2, '?')">
                <xsl:variable name="strParams">
                    <xsl:value-of select="cpm:morestr.leftAfterBefore($strRemain2, '?', '#')"/>
                </xsl:variable>
                <xsl:copy-of select="tokenize($strParams,'&amp;')"/>
            </xsl:if>
        </xsl:variable>
        
        
        <!-- Anchor -->
        
        <xsl:variable name="strAnchor">
            <xsl:if test="contains($strRemain2, '#')">
                <xsl:value-of select="substring-after($strRemain2, '#')"/>
            </xsl:if>
        </xsl:variable>
        
        
        <!-- Representing the URI as a sequence of XML elements -->
        
        <uri source="{$strURI}">
            
            <protocol>
                <xsl:value-of select="$strProtocol"/>
            </protocol>
            
            <xsl:if test="$strHost != ''">
                <host>
                    <xsl:value-of select="$strHost"/>
                </host>
                <xsl:if test="$strPort != ''">
                    <port>
                        <xsl:value-of select="$strPort"/>
                    </port>
                </xsl:if>
            </xsl:if>
            
            <xsl:if test="$strDrive != ''">
                <drive>
                    <xsl:value-of select="$strDrive"/>
                </drive>
            </xsl:if>
            
            <xsl:for-each select="$seqFiles[position() != last()]">
                <folder>
                    <xsl:value-of select="."/>
                </folder>
            </xsl:for-each>
            
            <xsl:if test="count($seqFiles) != 0">
                <file>
                    <xsl:value-of select="$seqFiles[position() = last()]"/>
                </file>
            </xsl:if>
            
            <xsl:for-each select="$seqParams">
                <param name="{substring-before(.,'=')}" value="{substring-after(.,'=')}"/>
            </xsl:for-each>
            
            <xsl:if test="$strAnchor != ''">
                <anchor>
                    <xsl:value-of select="$strAnchor"/>
                </anchor>
            </xsl:if>
            
        </uri>
        
    </xsl:function>
    
</xsl:stylesheet>