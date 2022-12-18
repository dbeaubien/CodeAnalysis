//%attributes = {"invisible":true}
// ExportDocs___Output_TF_NavHTML (methodCount) : navigationHTML
// ExportDocs___Output_TF_NavHTML (boolean): text
//
// DESCRIPTION
//   Returns the Table Form Methods HTML for the navigation section.
//
C_LONGINT:C283($1; $numTableFormMethods)
C_TEXT:C284($0; $html)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/07/2012)
//   Mod by: Dani Beaubien (01/25/2013) - Use "pretty" method names in the output.
//   Mod by: Dani Beaubien (01/31/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$numTableFormMethods:=$1
$html:=""

If ($numTableFormMethods>0)  // Output the Table Form Methods top of the tree:
	$html:=$html+"\t\t\t<ul class=\"jqueryFileTree\">"+Pref_GetEOL
	$html:=$html+"\t\t\t\t<li class=\"directory collapsed\">"+Pref_GetEOL
	$html:=$html+"\t\t\t\t\t<a href=\"\" class=\"directory\">Table Form/Object Methods ("+String:C10($numTableFormMethods)+")</a>"
	$html:=$html+"\t\t\t\t\t<ul class=\"jqueryFileTree\" style=\"display:none;\">"+Pref_GetEOL
End if 

If ($numTableFormMethods>0)  // Get the list of table form methods
	C_OBJECT:C1216(MethodStatsMasterObj)
	MethodStats__Init  // defines MethodStatsMasterObj
	MethodStats_RecalculateModified
	
	ARRAY TEXT:C222($methodObjNames; 0)
	Method_GetMethodObjNames(->$methodObjNames)
	Method_ReduceToNamesOfType(->$methodObjNames; "table form method")
End if 

If ($numTableFormMethods>0)  // Get the list of project form methods
	C_TEXT:C284($previousTableName; $previousFormName; $currentFormName; $currentTableName)
	$previousTableName:=Char:C90(Escape:K15:39)  // use some totally bogus value that will not match anything
	$previousFormName:=Char:C90(Escape:K15:39)  // use some totally bogus value that will not match anything
	$currentFormName:=""
	$currentTableName:=""
	
	C_BOOLEAN:C305($ulTagOpened)
	C_TEXT:C284($friendlyName; $vt_ObjectName)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($methodObjNames))
		$friendlyName:=Substring:C12($methodObjNames{$i}; Length:C16("[tableForm]/")+1)  // strip out the first part
		$currentTableName:=Substring:C12($friendlyName; 1; Position:C15("/"; $friendlyName)-1)
		$friendlyName:=Substring:C12($friendlyName; Position:C15("/"; $friendlyName)+1)  // Trim it down
		$currentFormName:=Substring:C12($friendlyName; 1; Position:C15("/"; $friendlyName)-1)
		$vt_ObjectName:=Substring:C12($friendlyName; Position:C15("/"; $friendlyName)+1)
		
		Case of 
			: ($previousTableName#$currentTableName)
				If ($i#1)
					If ($ulTagOpened)
						$ulTagOpened:=False:C215
						$html:=$html+"</ul></li>"+Pref_GetEOL  // Close out Form
						$html:=$html+"</ul>"+Pref_GetEOL  // Close out the form
					End if 
					$html:=$html+"</li>"+Pref_GetEOL  // Close out table
				End if 
				$ulTagOpened:=True:C214
				
				$previousTableName:=$currentTableName
				$previousFormName:=$currentFormName
				$html:=$html+"<li class=\"directory collapsed\"><a href=\"\" class=\"directory\">"+$currentTableName+" ("+String:C10(MethodScan_CountThatMatchPattrn("[tableForm]/"+$currentTableName+"/"))+")</a>"
				$html:=$html+"\t\t\t\t\t<ul class=\"jqueryFileTree\" style=\"display:none;\">"+Pref_GetEOL
				
				$html:=$html+"<li class=\"directory collapsed\"><a href=\"\" class=\"directory\">"+$currentFormName+" ("+String:C10(MethodScan_CountThatMatchPattrn("[tableForm]/"+$currentTableName+"/"+$currentFormName+"/"))+")</a>"
				$html:=$html+"\t\t\t\t\t<ul class=\"jqueryFileTree\" style=\"display:none;\">"+Pref_GetEOL
				
				
			: ($previousFormName#$currentFormName)
				$previousFormName:=$currentFormName
				$html:=$html+"</ul></li>"+Pref_GetEOL  // Close out Form
				
				$html:=$html+"<li class=\"directory collapsed\"><a href=\"\" class=\"directory\">"+$currentFormName+" ("+String:C10(MethodScan_CountThatMatchPattrn("[tableForm]/"+$currentTableName+"/"+$currentFormName+"/"))+")</a>"
				$html:=$html+"\t\t\t\t\t<ul class=\"jqueryFileTree\" style=\"display:none;\">"+Pref_GetEOL
				
		End case 
		
		$html:=$html+"\t\t\t\t\t\t<li class=\"file ext_txt\"><a href=\"Methods/"+Replace string:C233(Replace string:C233($methodObjNames{$i}; "/"; "-"); "%"; "%25")+".html\" target=\"methodFrame\">"+STR_URLDecode($vt_ObjectName)+"</a></li>"+Pref_GetEOL  //   Mod by: Dani Beaubien (01/25/2013) - Use "pretty" method names in the output.
	End for 
	
	$html:=$html+"</ul></li>"+Pref_GetEOL  // Close out Form
	$html:=$html+"</ul></li>"+Pref_GetEOL  // Close out Table
	$html:=$html+"</ul></li>"+Pref_GetEOL  // Close Header
	$html:=$html+"</ul>"+(Pref_GetEOL*2)
End if 

$0:=$html