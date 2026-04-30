//%attributes = {"invisible":true,"preemptive":"capable"}
// Array_RemoveElementIfExists (textArray; value)
//
// DESCRIPTION
//   Checks the text array for the passed value. If it is
//   present, then it is removed.
//
#DECLARE($textArray : Pointer; $value : Text)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=2))
	var $pos : Integer
	Repeat 
		$pos:=Find in array:C230($textArray->; $value)
		If ($pos>0)
			DELETE FROM ARRAY:C228($textArray->; $pos; 1)
		End if 
	Until ($pos<1)
End if 
