//%attributes = {"invisible":true}
// STR_TrimExcessSpaces
// 
// DESCRIPTION
//   Removes any beginning / trailing spaces from the string
//   Need to take care not to remove any spaces that are "inside" the string
//
#DECLARE($input : Text) : Text
// ----------------------------------------------------

If (Count parameters:C259=0)
	return ""
End if 

$input:=STR_Remove_Leading_Spaces($input)
$input:=STR_Remove_Trailing_Spaces($input)
return $input