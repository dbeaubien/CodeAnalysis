//%attributes = {"invisible":true}
// ExportDocs___Output_PM_NavHTML (methodCount; includeHeader) : navigationHTML
// ExportDocs___Output_PM_NavHTML (boolean): text
//
// DESCRIPTION
//   Returns the Project Method HTML for the navigation section.
//
C_LONGINT:C283($1; $numProjectMethods)
C_BOOLEAN:C305($2; $includeHeader)
C_BOOLEAN:C305($3; $onlyExportSharedMethods)
C_TEXT:C284($0; $html)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/07/2012)
//   Mod by: Dani Beaubien (01/30/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=3)
$numProjectMethods:=$1
$includeHeader:=$2
$onlyExportSharedMethods:=$3
$html:=""

If ($numProjectMethods>0)  // Output the Project Methods top level of tree:
	$html:=$html+"\t\t\t<ul class=\"jqueryFileTree\">"+Pref_GetEOL
	If ($includeHeader)
		$html:=$html+"\t\t\t\t<li class=\"directory collapsed\">"+Pref_GetEOL
		$html:=$html+"\t\t\t\t\t<a href=\"\" class=\"directory\">Project Methods ("+String:C10($numProjectMethods)+")</a>"
		$html:=$html+"\t\t\t\t\t<ul class=\"jqueryFileTree\" style=\"display:none;\">"+Pref_GetEOL
	Else 
		$html:=$html+"\t\t\t\t<li class=\"directory expanded\">"+Pref_GetEOL
		$html:=$html+"\t\t\t\t\t<a href=\"\" class=\"directory\">Shared Project Methods ("+String:C10($numProjectMethods)+")</a>"
		$html:=$html+"\t\t\t\t\t<ul class=\"jqueryFileTree\" style=\"display:block;\">"+Pref_GetEOL
	End if 
End if 

If ($numProjectMethods>0)
	C_OBJECT:C1216(MethodStatsMasterObj)
	MethodStats__Init  // defines MethodStatsMasterObj
	
	ARRAY TEXT:C222($methodObjNames; 0)
	Method_GetMethodObjNames(->$methodObjNames; $onlyExportSharedMethods)
	Method_ReduceToNamesOfType(->$methodObjNames; "project method")
	
	C_TEXT:C284($previousMethodModule)
	$previousMethodModule:=Char:C90(Escape:K15:39)  // use some totally bogus value that will not match anything
	
	C_OBJECT:C1216($moduleCounts)
	If (True:C214)  // get the counts for each module
		$moduleCounts:=New object:C1471
		
		C_LONGINT:C283($i)
		C_OBJECT:C1216($methodObj)
		For ($i; 1; Size of array:C274($methodObjNames))
			$methodObj:=MethodStatsMasterObj[$methodObjNames{$i}]
			If ($methodObj.in_module#"")
				
				If ($moduleCounts[$methodObj.in_module]=Null:C1517)
					$moduleCounts[$methodObj.in_module]:=New object:C1471("count"; 1)
				Else 
					$moduleCounts[$methodObj.in_module].count:=$moduleCounts[$methodObj.in_module].count+1
				End if 
			End if 
		End for 
	End if 
	
	C_LONGINT:C283($i)
	C_BOOLEAN:C305($ulTagOpened)
	C_OBJECT:C1216($methodObj)
	For ($i; 1; Size of array:C274($methodObjNames))
		$methodObj:=MethodStatsMasterObj[$methodObjNames{$i}]
		
		If ($previousMethodModule#$methodObj.in_module)  // start of a new module?
			If ($i#1)
				If ($ulTagOpened)
					$ulTagOpened:=False:C215
					$html:=$html+"</ul>"+Pref_GetEOL
				End if 
				$html:=$html+"</li>"+Pref_GetEOL
			End if 
			
			$previousMethodModule:=$methodObj.in_module
			If ($methodObj.in_module#"")
				$ulTagOpened:=True:C214
				$html:=$html+"<li class=\"directory collapsed\"><a href=\"\" class=\"directory\">"+$methodObj.in_module+" ("+String:C10(Num:C11($moduleCounts[$methodObj.in_module].count))+")</a>"
				$html:=$html+"\t\t\t\t\t<ul class=\"jqueryFileTree\" style=\"display:none;\">"+Pref_GetEOL
			End if 
		End if 
		
		$html:=$html+"\t\t\t\t\t\t<li class=\"file ext_txt\"><a href=\"Methods/"+Replace string:C233($methodObjNames{$i}; "/"; "-")+".html\" target=\"methodFrame\">"+$methodObj.path+"</a></li>"+Pref_GetEOL
		
	End for 
	
	If ($ulTagOpened)
		$ulTagOpened:=False:C215
		$html:=$html+"</ul></li>"+Pref_GetEOL
	End if 
	
	$html:=$html+"</ul></li>"+Pref_GetEOL
	$html:=$html+"</ul>"+(Pref_GetEOL*2)
	
End if 

$0:=$html