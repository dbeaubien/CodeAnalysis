//%attributes = {"invisible":true}
// STR_RightJustify (string; size)
//
// Description
//   Returns the string right justified to the set size.
//
#DECLARE($string : Text; $size : Integer) : Text
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	
	If (Length:C16($string)<$size)
		$string:=(" "*$size)+$string  // Add spaces on the left
	End if 
	
	return Substring:C12($string; Length:C16($string)-$size+1; $size)
End if 
