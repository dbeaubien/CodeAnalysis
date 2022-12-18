//%attributes = {"invisible":true}
// ExportDocs___Output_All_NavHTML : navigationHTML
// ExportDocs___Output_All_NavHTML : text
//
// DESCRIPTION
//   Returns the HTML for the navigation section of the HTML export.
//
C_TEXT:C284($0; $html)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/07/2012)
//   Mod by: Dani Beaubien (01/30/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=0)
$html:=""

C_BOOLEAN:C305($onlyExportSharedMethods)
$onlyExportSharedMethods:=(Pref_GetPrefString("HTML do Component View"; "0")="1")

C_LONGINT:C283($numProjectMethods; $numProjectFormMethods; $numTableFormMethods; $numDatabaseMethods; $numTriggerMethods)
If ($onlyExportSharedMethods)
	ARRAY TEXT:C222($methodObjNames; 0)
	Method_GetMethodObjNames(->$methodObjNames; $onlyExportSharedMethods)
	
	C_TEXT:C284($typeOfMethod)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($methodObjNames))
		$typeOfMethod:=Method_GetTypeFromPath($methodObjNames{$i})
		
		Case of 
			: ($typeOfMethod="project form method")
				$numProjectFormMethods:=$numProjectFormMethods+1
				
			: ($typeOfMethod="table form method")
				$numTableFormMethods:=$numTableFormMethods+1
				
			: ($typeOfMethod="database method")
				$numDatabaseMethods:=$numDatabaseMethods+1
				
			: ($typeOfMethod="trigger method")
				$numTriggerMethods:=$numTriggerMethods+1
				
			Else 
				$numProjectMethods:=$numProjectMethods+1
		End case 
		
	End for 
	
Else 
	$numProjectMethods:=Storage:C1525.methodStatsSummary.numProjectMethods
	$numProjectFormMethods:=Storage:C1525.methodStatsSummary.numProjectFormMethods
	$numTableFormMethods:=Storage:C1525.methodStatsSummary.numTableFormMethods
	$numDatabaseMethods:=Storage:C1525.methodStatsSummary.numDatabaseMethods
	$numTriggerMethods:=Storage:C1525.methodStatsSummary.numTriggerMethods
End if 

// Output the Project Methods:
C_BOOLEAN:C305($includeHeader)
If ($numProjectMethods#Storage:C1525.methodStatsSummary.numMethods)
	$includeHeader:=True:C214
End if 

$html:=$html+"\t\t<div id=\"fileTreeDemo_1\" class=\"demo\">"+Pref_GetEOL
$html:=$html+ExportDocs___Output_PM_NavHTML($numProjectMethods; $includeHeader; $onlyExportSharedMethods)  // project methods
If (Not:C34($onlyExportSharedMethods))
	$html:=$html+ExportDocs___Output_PF_NavHTML($numProjectFormMethods)  // project form methods
	$html:=$html+ExportDocs___Output_TF_NavHTML($numTableFormMethods)  // table form methods
	$html:=$html+ExportDocs___Output_DM_NavHTML($numDatabaseMethods)  // database methods
	$html:=$html+ExportDocs___Output_TM_NavHTML($numTriggerMethods)  // trigger methods
End if 
$html:=$html+"\t\t</div>"+Pref_GetEOL

$0:=$html