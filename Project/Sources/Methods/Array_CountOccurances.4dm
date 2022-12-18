//%attributes = {"invisible":true}
// Array_CountOccurances (ArrayPtr, textToCount) : number of occurances
// Array_CountOccurances (pointer; text) : longint
//
// DESCRIPTION
//   Counts the number of times that the token appears in the array
//
C_POINTER:C301($1; $ap_arrayPtr)
C_TEXT:C284($2; $vt_textToFind)
C_LONGINT:C283($0; $vl_numberOfOccurancesInArray)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (09/25/2012)
// ----------------------------------------------------

$vl_numberOfOccurancesInArray:=0
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$ap_arrayPtr:=$1
	$vt_textToFind:=$2
	
	C_LONGINT:C283($pos)
	Repeat 
		$pos:=Find in array:C230($ap_arrayPtr->; $vt_textToFind; $pos)
		If ($pos>0)
			$vl_numberOfOccurancesInArray:=$vl_numberOfOccurancesInArray+1
			$pos:=$pos+1  // move to next pos
		End if 
	Until ($pos<0)
	
End if   // ASSERT
$0:=$vl_numberOfOccurancesInArray
