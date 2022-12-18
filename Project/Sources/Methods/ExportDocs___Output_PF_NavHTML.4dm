//%attributes = {"invisible":true}
// ExportDocs___Output_PF_NavHTML (methodCount) : navigationHTML
// ExportDocs___Output_PF_NavHTML (boolean): text
//
// DESCRIPTION
//   Returns the Project Form Methods HTML for the navigation section.
//
C_LONGINT:C283($1; $numProjectFormMethods)
C_TEXT:C284($0; $html)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/07/2012)
//   Mod by: Dani Beaubien (01/25/2013) - Use "pretty" method names in the output.
//   Mod by: Dani Beaubien (01/31/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$numProjectFormMethods:=$1
$html:=""

If ($numProjectFormMethods>0)  // Output the Project Form Methods top level of tree
	$html:=$html+"\t\t\t<ul class=\"jqueryFileTree\">"+Pref_GetEOL
	$html:=$html+"\t\t\t\t<li class=\"directory collapsed\">"+Pref_GetEOL
	$html:=$html+"\t\t\t\t\t<a href=\"\" class=\"directory\">Project Form/Object Methods ("+String:C10($numProjectFormMethods)+")</a>"
	$html:=$html+"\t\t\t\t\t<ul class=\"jqueryFileTree\" style=\"display:none;\">"+Pref_GetEOL
End if 

If ($numProjectFormMethods>0)  // Get the list of project form methods
	C_OBJECT:C1216(MethodStatsMasterObj)
	MethodStats__Init  // defines MethodStatsMasterObj
	
	ARRAY TEXT:C222($methodObjNames; 0)
	Method_GetMethodObjNames(->$methodObjNames)
	Method_ReduceToNamesOfType(->$methodObjNames; "project form method")
End if 

If ($numProjectFormMethods>0)
	C_TEXT:C284($friendlyName; $vt_ObjectName)
	
	C_TEXT:C284($previousFormName; $currentFormName)
	$previousFormName:=Char:C90(Escape:K15:39)  // use some totally bogus value that will not match anything
	
	C_LONGINT:C283($i)
	C_BOOLEAN:C305($ulTagOpened)
	For ($i; 1; Size of array:C274($methodObjNames))
		$friendlyName:=Substring:C12($methodObjNames{$i}; Length:C16("[projectForm]/")+1)  // strip out the first part
		$currentFormName:=Substring:C12($friendlyName; 1; Position:C15("/"; $friendlyName)-1)
		$vt_ObjectName:=Substring:C12($friendlyName; Position:C15("/"; $friendlyName)+1)
		
		If ($previousFormName#$currentFormName)
			If ($i#1)
				If ($ulTagOpened)
					$ulTagOpened:=False:C215
					$html:=$html+"</ul>"+Pref_GetEOL
				End if 
				$html:=$html+"</li>"+Pref_GetEOL
			End if 
			
			$previousFormName:=$currentFormName
			$ulTagOpened:=True:C214
			
			$html:=$html+"<li class=\"directory collapsed\"><a href=\"\" class=\"directory\">"+$currentFormName+" ("+String:C10(MethodScan_CountThatMatchPattrn("[projectForm]/"+$currentFormName+"/"))+")</a>"
			$html:=$html+"\t\t\t\t\t<ul class=\"jqueryFileTree\" style=\"display:none;\">"+Pref_GetEOL
		End if 
		
		$html:=$html+"\t\t\t\t\t\t<li class=\"file ext_txt\"><a href=\"Methods/"+Replace string:C233(Replace string:C233($methodObjNames{$i}; "/"; "-"); "%"; "%25")+".html\" target=\"methodFrame\">"+STR_URLDecode($vt_ObjectName)+"</a></li>"+Pref_GetEOL  // Use "pretty" method names in the output.
	End for 
	
	If ($ulTagOpened)
		$ulTagOpened:=False:C215
		$html:=$html+"</ul></li>"+Pref_GetEOL
	End if 
	
	$html:=$html+"</ul></li>"+Pref_GetEOL  // Close Header
	$html:=$html+"</ul>"+(Pref_GetEOL*2)
	
End if 

$0:=$html