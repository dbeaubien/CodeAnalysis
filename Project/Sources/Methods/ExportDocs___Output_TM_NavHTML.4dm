//%attributes = {"invisible":true}
// ExportDocs___Output_TM_NavHTML (methodCount) : navigationHTML
//
// DESCRIPTION
//   Returns the trigger Methods HTML for the navigation section.
//
#DECLARE($numTriggerMethods : Integer)->$html : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$html:=""

If ($numTriggerMethods>0)  // Output the trigger methods top level of tree
	// Output the Project Methods:
	$html:=$html+"\t\t\t<ul class=\"jqueryFileTree\">"+Pref_GetEOL
	$html:=$html+"\t\t\t\t<li class=\"directory collapsed\">"+Pref_GetEOL
	$html:=$html+"\t\t\t\t\t<a href=\"\" class=\"directory\">"+"Trigger Methods ("+String:C10($numTriggerMethods)+")</a>"
	$html:=$html+"\t\t\t\t\t<ul class=\"jqueryFileTree\" style=\"display:none;\">"+Pref_GetEOL
End if 

If ($numTriggerMethods>0)  // Get the list of trigger methods
	var MethodStatsMasterObj : Object
	MethodStats__Init  // defines MethodStatsMasterObj
	
	ARRAY TEXT:C222($methodObjNames; 0)
	Method_GetMethodObjNames(->$methodObjNames)
	Method_ReduceToNamesOfType(->$methodObjNames; "trigger method")
End if 

If ($numTriggerMethods>0)  // Output all the methods
	var $friendlyName : Text
	var $i : Integer
	For ($i; 1; Size of array:C274($methodObjNames))
		$friendlyName:="["+Substring:C12($methodObjNames{$i}; Length:C16("[trigger]/")+1)+"]"  // strip out the first part
		$html:=$html+"\t\t\t\t\t\t<li class=\"file ext_txt\"><a href=\"Methods/"+Replace string:C233($methodObjNames{$i}; "/"; "-")+".html\" target=\"methodFrame\">"+$friendlyName+"</a></li>"+Pref_GetEOL
	End for 
	
	// Close everything off
	$html:=$html+"\t\t\t\t</ul></li>"+Pref_GetEOL  // Close Header
	$html:=$html+"\t\t\t</ul>"+Pref_GetEOL
End if 
