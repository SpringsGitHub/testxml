<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="utf-8" method="html" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR...ansitional.dtd" />
<!-- Style sheet for QAC report -->

<!-- ********************************************************************************************************** -->
<!-- MAIN TEMPLATE -->
<!-- ********************************************************************************************************** -->
<xsl:template match="/"> 
	<html> 
		<head> 
			<title> 
				Overflow Checker Report
			</title> 
		</head> 
		
		<body onLoad="javascript:resize_textarea()">
			<!-- Load all necessary javascript files -->
            <script language="javascript" type="text/javascript" src="ov_checker_java_script.js"></script>
			<xsl:apply-templates select="overflow_checker_report"/>
		</body>
	</html> 
</xsl:template>

<xsl:template match="overflow_checker_report">
<form name="formID" onsubmit="return false;">
<h1><center><font color='firebrick'>Overflow Checker Report</font></center></h1>
<h2><font color='royalblue'><u>1 - General Information</u></font></h2>
	<table border="1" bordercolor="black"  cellspacing="0">
		<tr><th bgcolor="whitesmoke">Version</th><td><xsl:value-of select="overflow_checker_version"/></td></tr>
		<tr><th bgcolor="whitesmoke">Model</th><td><xsl:value-of select="model"/></td></tr>
        <tr><th bgcolor="whitesmoke">Date</th><td><xsl:value-of select="generation_date"/></td></tr>
    </table>
<h2><font color='royalblue'><u>2 - Results</u></font></h2>

<xsl:choose>
<xsl:when test="count(//error) &gt;  0">
    <h3><font color='red'>
    <br/><xsl:value-of select="count(//error)"/> errors have been detected. Please correct them.
    <br/>if an error is intentional, fill the justification area and click on the 'save XML report' button
    <br/>
    </font>
    </h3>
</xsl:when>
<xsl:otherwise>
    <h3><font color='green'>
    <br/>No error detected
    <br/>
    </font>
    </h3>
</xsl:otherwise>
</xsl:choose>

<xsl:for-each select="rules/rule">

    <h3><font color='royalblue'><u>Rule: <xsl:value-of select="name"/></u></font></h3>

        <br/><b>Description:</b>&#160;<xsl:value-of select="description"/>
		<br/><b>Priority:</b>&#160;<xsl:value-of select="priority"/>
        <br/>
        <br/>
        <table border="1" bordercolor="black"  cellspacing="0">
        <tr><th bgcolor="whitesmoke">Description</th><th bgcolor="whitesmoke">Path</th><th bgcolor="whitesmoke">Justification</th> </tr>
        <xsl:for-each select="error">
            <tr><td><xsl:value-of select="rule_type"/></td><td>
            <xsl:for-each select="block_path">
            <xsl:element name="a">
                <xsl:attribute name="href">
                    matlab:stModelUtils('highlight_unhighlightBlock','<xsl:value-of select="."/>');
                </xsl:attribute>
                <xsl:value-of select="."/><br/>
            </xsl:element>
            </xsl:for-each>
            </td><td><textarea name="user_error_justification" rows="3" cols="20"><xsl:value-of select="justification"/></textarea></td></tr>
         </xsl:for-each>
         </table>
        
</xsl:for-each>
<br/>
<center><button onClick="javascript:save_report()"><b>SAVE XML REPORT</b></button></center>
</form>
 
 </xsl:template>
 </xsl:stylesheet>