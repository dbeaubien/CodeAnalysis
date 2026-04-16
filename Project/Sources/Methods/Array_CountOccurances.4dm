//%attributes = {"invisible":true}
// Array_CountOccurances (ArrayPtr, textToCount) : number of occurances
//
// DESCRIPTION
//   Counts the number of times that the token appears in the array
//
#DECLARE($ap_arrayPtr : Pointer\
; $vt_textToFind : Text)->$vl_numberOfOccurancesInArray : Integer
// ----------------------------------------------------
$vl_numberOfOccurancesInArray:=0

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	
	var $pos : Integer
	Repeat 
		$pos:=Find in array:C230($ap_arrayPtr->; $vt_textToFind; $pos)
		If ($pos>0)
			$vl_numberOfOccurancesInArray:=$vl_numberOfOccurancesInArray+1
			$pos:=$pos+1  // move to next pos
		End if 
	Until ($pos<0)
	
End if 

