//%attributes = {"invisible":true}
// ExportDocs___Output_All_NavHTML : navigationHTML
//
// DESCRIPTION
//   Returns the HTML for the navigation section of the HTML export.
//
#DECLARE()->$html : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=0)
$html:=""

var $onlyExportSharedMethods : Boolean
$onlyExportSharedMethods:=(Pref_GetPrefString("HTML do Component View"; "0")="1")

var $numProjectMethods; $numProjectFormMethods; $numTableFormMethods; $numDatabaseMethods; $numTriggerMethods : Integer
If ($onlyExportSharedMethods)
	ARRAY TEXT:C222($methodObjNames; 0)
	Method_GetMethodObjNames(->$methodObjNames; $onlyExportSharedMethods)
	
	var $typeOfMethod : Text
	var $i : Integer
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
var $includeHeader : Boolean
If ($numProjectMethods#Storage:C1525.methodStatsSummary.numMethods)
	$includeHeader:=True:C214
End if 

$html+="\t\t<div id=\"fileTreeDemo_1\" class=\"demo\">"+Pref_GetEOL
$html+=ExportDocs___Output_PM_NavHTML($numProjectMethods; $includeHeader; $onlyExportSharedMethods)  // project methods
If (Not:C34($onlyExportSharedMethods))
	$html+=ExportDocs___Output_PF_NavHTML($numProjectFormMethods)  // project form methods
	$html+=ExportDocs___Output_TF_NavHTML($numTableFormMethods)  // table form methods
	$html+=ExportDocs___Output_DM_NavHTML($numDatabaseMethods)  // database methods
	$html+=ExportDocs___Output_TM_NavHTML($numTriggerMethods)  // trigger methods
End if 
$html+="\t\t</div>"+Pref_GetEOL
