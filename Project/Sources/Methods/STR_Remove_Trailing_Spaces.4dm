//%attributes = {"invisible":true}
// STR_Remove_Trailing_Spaces
#DECLARE($input : Text)->$output : Text

If ($input="")
	return ""
End if 

If ($input#"@ ")
	$output:=$input
	return 
End if 

var $i : Integer
For ($i; Length:C16($input); 1; -1)  // Loop from end of string to beginning
	If ($input[[$i]]#" ")  // If it is -NOT- a space, then
		$i:=-$i  // force the loop to end (remember the spot)
	End if 
End for 

$output:=Delete string:C232($input; -$i; Length:C16($input))  // Delete the spaces