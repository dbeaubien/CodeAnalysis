//%attributes = {"invisible":true}
// MethodCode_RemoveBlankLines (srcMethodCode) : trimmedMethodCode
//
// DESCRIPTION
//   Removes all the blank lines from the method code.
//
#DECLARE($vt_srcMethodCode : Text)->$vt_trimmedMethodCode : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$vt_trimmedMethodCode:=""

If ($vt_srcMethodCode#"")
	ARRAY TEXT:C222($at_codeLines; 0)
	ARRAY_Unpack($vt_srcMethodCode; ->$at_codeLines; Pref_GetEOL)
	
	var $i : Integer
	For ($i; Size of array:C274($at_codeLines); 1; -1)
		If ($at_codeLines{$i}="")  // is current line a blank?
			DELETE FROM ARRAY:C228($at_codeLines; $i; 1)
		End if 
	End for 
	
	$vt_trimmedMethodCode:=Array_ConvertToTextDelimited(->$at_codeLines; Pref_GetEOL)
Else 
	$vt_trimmedMethodCode:=$vt_srcMethodCode
End if 
