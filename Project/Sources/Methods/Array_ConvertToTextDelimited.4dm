//%attributes = {"invisible":true}
// Array_ConvertToTextDelimited (arrayToConvert{; delimiter}) : delimitedText
// 
// DESCRIPTION
//   Converts the passed text array into a delimited
//   text string. Defaults to "," delimiter.
//
#DECLARE($vp_arrayPtr : Pointer; $delimiter : Text)->$vt_delimitedText : Text
// ----------------------------------------------------
$vt_delimitedText:=""

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	If ($delimiter="")
		$delimiter:=","
	End if 
	
	var $i : Integer
	For ($i; 1; Size of array:C274($vp_arrayPtr->))
		$vt_delimitedText+=$vp_arrayPtr->{$i}
		$vt_delimitedText+=Choose:C955($i<Size of array:C274($vp_arrayPtr->); $delimiter; "")
	End for 
	
End if 
