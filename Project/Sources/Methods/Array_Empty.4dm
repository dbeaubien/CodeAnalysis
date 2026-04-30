//%attributes = {"invisible":true,"preemptive":"capable"}
// Array_Empty (array of values)
// 
// DESCRIPTION
//   Removes any and all elements in the array
//
#DECLARE($arrayPtr : Pointer)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=1))
	var $pos : Integer
	$pos:=Size of array:C274($arrayPtr->)
	If ($pos>0)
		DELETE FROM ARRAY:C228($arrayPtr->; 1; $pos)
	End if 
End if 

