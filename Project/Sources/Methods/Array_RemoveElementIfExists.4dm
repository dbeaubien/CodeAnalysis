//%attributes = {"invisible":true,"preemptive":"capable"}
// Array_RemoveElementIfExists (textArray; value)
// Array_RemoveElementIfExists (pointer; text)
//
// DESCRIPTION
//   Checks the text array for the passed value. If it is
//   present, then it is removed.
//
C_POINTER:C301($1; $textArray)
C_TEXT:C284($2; $value)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/15/2017)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=2))
	$textArray:=$1
	$value:=$2
	
	C_LONGINT:C283($pos)
	Repeat 
		$pos:=Find in array:C230($textArray->; $value)
		If ($pos>0)
			DELETE FROM ARRAY:C228($textArray->; $pos; 1)
		End if 
	Until ($pos<1)
End if 
