//%attributes = {"invisible":true}
// ExportDocs___Output_DM_NavHTML (methodCount) : navigationHTML
// ExportDocs___Output_DM_NavHTML (boolean): text
//
// DESCRIPTION
//   Returns the database Methods HTML for the navigation section.
//
C_LONGINT:C283($1; $numDatabaseMethods)
C_TEXT:C284($0; $html)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/07/2012)
//   Mod by: Dani Beaubien (01/31/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$numDatabaseMethods:=$1
$html:=""

If ($numDatabaseMethods>0)  // Output the Database Methods top level of tree
	$html:=$html+"\t\t\t<ul class=\"jqueryFileTree\">"+Pref_GetEOL
	$html:=$html+"\t\t\t\t<li class=\"directory collapsed\">"+Pref_GetEOL
	$html:=$html+"\t\t\t\t\t<a href=\"\" class=\"directory\">Database Methods ("+String:C10($numDatabaseMethods)+")</a>"
	$html:=$html+"\t\t\t\t\t<ul class=\"jqueryFileTree\" style=\"display:none;\">"+Pref_GetEOL
End if 

If ($numDatabaseMethods>0)  // Get the list of database methods
	C_OBJECT:C1216(MethodStatsMasterObj)
	MethodStats__Init  // defines MethodStatsMasterObj
	
	ARRAY TEXT:C222($methodObjNames; 0)
	Method_GetMethodObjNames(->$methodObjNames)
	Method_ReduceToNamesOfType(->$methodObjNames; "database method")
End if 

If ($numDatabaseMethods>0)  // Output all the database methods
	C_TEXT:C284($friendlyName)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($methodObjNames))
		$friendlyName:=Substring:C12($methodObjNames{$i}; Length:C16("[databaseMethod]/")+1)  // strip out the first part
		
		$friendlyName:=STR_SeparateOnCapitals($friendlyName)
		
		$html:=$html+"\t\t\t\t\t\t<li class=\"file ext_txt\"><a href=\"Methods/"+Replace string:C233($methodObjNames{$i}; "/"; "-")+".html\" target=\"methodFrame\">"+$friendlyName+"</a></li>"+Pref_GetEOL
	End for 
	
	// Close everything off
	$html:=$html+"\t\t\t\t</ul></li>"+Pref_GetEOL  // Close Header
	$html:=$html+"\t\t\t</ul>"+Pref_GetEOL
End if 

$0:=$html