//%attributes = {"invisible":true}
// MethodCode_RemoveAttributeLine (srcMethodCode) : trimmedMethodCode
// MethodCode_RemoveAttributeLine (text) : text
//
// DESCRIPTION
//   Removes the "attribute" line (1st line) from the method code.
//
C_TEXT:C284($1; $vt_srcMethodCode)
C_TEXT:C284($0; $vt_trimmedMethodCode)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/04/2012)
// ----------------------------------------------------

$vt_trimmedMethodCode:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_srcMethodCode:=$1
	
	If ($vt_srcMethodCode="//%attributes = {@")  // Is the first line the actual attribute line?
		C_LONGINT:C283($pos)
		$pos:=Position:C15(Pref_GetEOL; $vt_srcMethodCode)
		If ($pos>0)
			$vt_trimmedMethodCode:=Substring:C12($vt_srcMethodCode; $pos+Length:C16(Pref_GetEOL))
		Else 
			$vt_trimmedMethodCode:=""
		End if 
		
	Else 
		$vt_trimmedMethodCode:=$vt_srcMethodCode
	End if 
	
End if   // ASSERT
$0:=$vt_trimmedMethodCode
