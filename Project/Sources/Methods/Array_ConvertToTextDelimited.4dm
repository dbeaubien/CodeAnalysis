//%attributes = {"invisible":true}
// Array_ConvertToTextDelimited (arrayToConvert{; delimiter}) : delimitedText
// Array_ConvertToTextDelimited (arrPtr{; text}) : text
// 
// DESCRIPTION
//   Converts the passed text array into a delimited
//   text string. Defaults to "," delimiter.
//
C_POINTER:C301($1; $vp_arrayPtr)
C_TEXT:C284($2; $vt_theDelimiter)
C_TEXT:C284($0; $vt_delimitedText)
// ----------------------------------------------------
// CALLLED BY:
//   [EnterIfAppropriate]
// ----------------------------------------------------
//   Created by: DB (04/20/07)
// ----------------------------------------------------

$vt_delimitedText:=""

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	$vp_arrayPtr:=$1
	If (Count parameters:C259=2)
		$vt_theDelimiter:=$2
	Else 
		$vt_theDelimiter:=","
	End if 
	
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($vp_arrayPtr->))
		$vt_delimitedText:=$vt_delimitedText+$vp_arrayPtr->{$i}
		$vt_delimitedText:=$vt_delimitedText+Choose:C955($i<Size of array:C274($vp_arrayPtr->); $vt_theDelimiter; "")
	End for 
	
End if   // ASSERT

$0:=$vt_delimitedText
