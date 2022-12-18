//%attributes = {"invisible":true}
// ExportDocs__SaveMainHtmlPage (root Folder)
//
// DESCRIPTION
//   Outputs the results of the method scan to HTML files.
//
C_TEXT:C284($1; $rootFolder)
// ----------------------------------------------------
// User name (OS): Dani Beaubien
// Date and time: 03/07/12, 12:22:56
//   Mod by: Dani Beaubien (10/02/2012) - Add support to limit to just methods viewable by the host DB
//   Mod by: Dani Beaubien (01/28/2021) - Refactored to use objects rather than arrays.
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$rootFolder:=$1

C_BOOLEAN:C305($onlyExportSharedMethods)
C_TEXT:C284($templateSourceFolder)
ARRAY TEXT:C222($methodObjNames; 0)
C_LONGINT:C283($i; $numMethods)
If (True:C214)  // prep our vars and files
	$onlyExportSharedMethods:=(Pref_GetPrefString("HTML do Component View"; "0")="1")
	$templateSourceFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"HTML Tempates"+Folder separator:K24:12
	
	// ## Copy template files from the Resouce folder to the destination folder
	Folder_Copy($templateSourceFolder+"css"; $rootFolder+"css"; New collection:C1472)
	Folder_Copy($templateSourceFolder+"js"; $rootFolder+"js"; New collection:C1472)
	Folder_Copy($templateSourceFolder+"images"; $rootFolder+"images"; New collection:C1472)
	
	C_OBJECT:C1216(MethodStatsMasterObj)
	MethodStats__Init
	OB GET PROPERTY NAMES:C1232(MethodStatsMasterObj; $methodObjNames)
	$numMethods:=Size of array:C274($methodObjNames)
End if 


C_TEXT:C284($html)
If (File_DoesExist($templateSourceFolder+"index-template.html"))
	$html:=Document to text:C1236($templateSourceFolder+"index-template.html")
End if 


// ## Generate the HTML for the navigation section
C_TEXT:C284($navigationHtml)
$navigationHtml:=""
//$navigationHtml:="<b>"+String($numMethods)+" Methods:</b><br/>"
$navigationHtml:=$navigationHtml+"<p>"+ExportDocs___Output_All_NavHTML+"</p>"

If (Not:C34($onlyExportSharedMethods))
	
	C_LONGINT:C283($vl_TOTAL_LINE_codeOnly; $vl_TOTAL_LINE_comments; $vl_TOTAL_LINE_blank; $vl_TOTAL_LINE_cComplexity)
	$vl_TOTAL_LINE_codeOnly:=Storage:C1525.methodStatsSummary.numCodeLines
	$vl_TOTAL_LINE_comments:=Storage:C1525.methodStatsSummary.numCommentLines
	$vl_TOTAL_LINE_blank:=Storage:C1525.methodStatsSummary.numBlankLines
	For ($i; 1; Size of array:C274($methodObjNames))
		If ($methodObjNames{$i}#"object_format_version")
			$vl_TOTAL_LINE_cComplexity:=$vl_TOTAL_LINE_cComplexity+MethodStatsMasterObj[$methodObjNames{$i}].analysis.complexity
		End if 
	End for 
	
	$navigationHtml:=$navigationHtml+"<br/>Number of Methods: "+String:C10($numMethods)+"<br/><br/>"
	
	
	C_LONGINT:C283($vl_TOTAL_LINE_total)
	$vl_TOTAL_LINE_total:=$vl_TOTAL_LINE_codeOnly+$vl_TOTAL_LINE_comments+$vl_TOTAL_LINE_blank
	
	$navigationHtml:=$navigationHtml+"Total Lines: "+String:C10($vl_TOTAL_LINE_total; "###,###,000")+"<br/>"
	$navigationHtml:=$navigationHtml+"Code Lines: "+String:C10($vl_TOTAL_LINE_codeOnly; "###,###,000")+"<br/>"
	$navigationHtml:=$navigationHtml+"Comment Lines: "+String:C10($vl_TOTAL_LINE_comments; "###,###,000")+"<br/>"
	$navigationHtml:=$navigationHtml+"Blank Lines: "+String:C10($vl_TOTAL_LINE_blank; "###,###,000")+"<br/>"
	
	$navigationHtml:=$navigationHtml+"Total Cyclomatic Complexity: "+String:C10($vl_TOTAL_LINE_cComplexity; "###,###,000")+"<br/>"
	
	If ($numMethods>1)
		$navigationHtml:=$navigationHtml+"<br/>"
		$navigationHtml:=$navigationHtml+"Method Averages:<br/>"
		$navigationHtml:=$navigationHtml+" "+String:C10($vl_TOTAL_LINE_codeOnly/$numMethods; "###,###,###.0")+" Lines of Code<br/>"
		$navigationHtml:=$navigationHtml+" "+String:C10($vl_TOTAL_LINE_comments/$numMethods; "###,###,###.0")+" Comment Lines<br/>"
		$navigationHtml:=$navigationHtml+" "+String:C10($vl_TOTAL_LINE_blank/$numMethods; "###,###,###.0")+" Blank Lines<br/>"
		$navigationHtml:=$navigationHtml+" "+String:C10($vl_TOTAL_LINE_cComplexity/$numMethods; "###,###,###.0")+" Cyclomatic Complexity<br/>"
	End if 
End if 


$html:=Replace string:C233($html; "###PageTitle###"; File_GetFileName(Structure file:C489(*)))
$html:=Replace string:C233($html; "###HeaderText###"; File_GetFileName(Structure file:C489(*)))
$html:=Replace string:C233($html; "###Navigation###"; $navigationHtml)


TEXT TO DOCUMENT:C1237($rootFolder+"index.html"; $html; "utf-8")