//%attributes = {"invisible":true}
// MethodCode_RemoveAttributeLine (srcMethodCode) : trimmedMethodCode
//
// DESCRIPTION
//   Removes the "attribute" line (1st line) from the method code.
//
#DECLARE($vt_srcMethodCode : Text)->$vt_trimmedMethodCode : Text
// ----------------------------------------------------
$vt_trimmedMethodCode:=""

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	If ($vt_srcMethodCode="//%attributes = {@")  // Is the first line the actual attribute line?
		var $pos : Integer
		$pos:=Position:C15(Pref_GetEOL; $vt_srcMethodCode)
		If ($pos>0)
			$vt_trimmedMethodCode:=Substring:C12($vt_srcMethodCode; $pos+Length:C16(Pref_GetEOL))
		Else 
			$vt_trimmedMethodCode:=""
		End if 
		
	Else 
		$vt_trimmedMethodCode:=$vt_srcMethodCode
	End if 
	
End if 
