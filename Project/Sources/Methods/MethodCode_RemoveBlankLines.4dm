//%attributes = {"invisible":true}
// MethodCode_RemoveBlankLines (srcMethodCode) : trimmedMethodCode
// MethodCode_RemoveBlankLines (text) : text
//
// DESCRIPTION
//   Removes all the blank lines from the method code.
//
C_TEXT:C284($1; $vt_srcMethodCode)
C_TEXT:C284($0; $vt_trimmedMethodCode)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/04/2012)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$vt_srcMethodCode:=$1
$vt_trimmedMethodCode:=""

If ($vt_srcMethodCode#"")
	ARRAY TEXT:C222($at_codeLines; 0)
	ARRAY_Unpack($vt_srcMethodCode; ->$at_codeLines; Pref_GetEOL)
	
	C_LONGINT:C283($i)
	For ($i; Size of array:C274($at_codeLines); 1; -1)
		If ($at_codeLines{$i}="")  // is current line a blank?
			DELETE FROM ARRAY:C228($at_codeLines; $i; 1)
		End if 
	End for 
	
	$vt_trimmedMethodCode:=Array_ConvertToTextDelimited(->$at_codeLines; Pref_GetEOL)
Else 
	$vt_trimmedMethodCode:=$vt_srcMethodCode
End if 

$0:=$vt_trimmedMethodCode