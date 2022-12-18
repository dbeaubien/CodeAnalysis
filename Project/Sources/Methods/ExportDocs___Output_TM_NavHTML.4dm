//%attributes = {"invisible":true}
// ExportDocs___Output_TM_NavHTML (methodCount) : navigationHTML
// ExportDocs___Output_TM_NavHTML (boolean): text
//
// DESCRIPTION
//   Returns the trigger Methods HTML for the navigation section.
//
C_LONGINT:C283($1; $numTriggerMethods)
C_TEXT:C284($0; $html)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/07/2012)
//   Mod by: Dani Beaubien (01/31/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$numTriggerMethods:=$1
$html:=""

If ($numTriggerMethods>0)  // Output the trigger methods top level of tree
	// Output the Project Methods:
	$html:=$html+"\t\t\t<ul class=\"jqueryFileTree\">"+Pref_GetEOL
	$html:=$html+"\t\t\t\t<li class=\"directory collapsed\">"+Pref_GetEOL
	$html:=$html+"\t\t\t\t\t<a href=\"\" class=\"directory\">"+"Trigger Methods ("+String:C10($numTriggerMethods)+")</a>"
	$html:=$html+"\t\t\t\t\t<ul class=\"jqueryFileTree\" style=\"display:none;\">"+Pref_GetEOL
End if 

If ($numTriggerMethods>0)  // Get the list of trigger methods
	C_OBJECT:C1216(MethodStatsMasterObj)
	MethodStats__Init  // defines MethodStatsMasterObj
	
	ARRAY TEXT:C222($methodObjNames; 0)
	Method_GetMethodObjNames(->$methodObjNames)
	Method_ReduceToNamesOfType(->$methodObjNames; "trigger method")
End if 

If ($numTriggerMethods>0)  // Output all the methods
	C_TEXT:C284($friendlyName)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($methodObjNames))
		$friendlyName:="["+Substring:C12($methodObjNames{$i}; Length:C16("[trigger]/")+1)+"]"  // strip out the first part
		$html:=$html+"\t\t\t\t\t\t<li class=\"file ext_txt\"><a href=\"Methods/"+Replace string:C233($methodObjNames{$i}; "/"; "-")+".html\" target=\"methodFrame\">"+$friendlyName+"</a></li>"+Pref_GetEOL
	End for 
	
	// Close everything off
	$html:=$html+"\t\t\t\t</ul></li>"+Pref_GetEOL  // Close Header
	$html:=$html+"\t\t\t</ul>"+Pref_GetEOL
End if 

$0:=$html