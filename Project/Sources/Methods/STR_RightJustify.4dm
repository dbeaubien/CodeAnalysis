//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: STR_RightJustify (string; size)
// Description
//   Returns the string right justified to the set size.
//
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_TEXT:C284($0)
// ----------------------------------------------------
// User name (OS): Dani Beaubien
// Date and time: 03/07/12, 07:35:59
// ----------------------------------------------------

$0:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	
	If (Length:C16($1)<$2)
		$1:=(" "*$2)+$1  // Add spaces on the left
	End if 
	
	$0:=Substring:C12($1; Length:C16($1)-$2+1; $2)
End if 
