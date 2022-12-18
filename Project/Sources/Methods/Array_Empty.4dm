//%attributes = {"invisible":true,"preemptive":"capable"}
// Array_Empty (array of values)
// Array_Empty (pointer to array)
// 
// DESCRIPTION
//   Removes any and all elements in the array
//
C_POINTER:C301($1; $arrayPtr)
// ----------------------------------------------------
// HISTORY
//    Created by: DB (09/19/04)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=1))
	$arrayPtr:=$1
	
	C_LONGINT:C283($pos)
	$pos:=Size of array:C274($arrayPtr->)
	If ($pos>0)
		DELETE FROM ARRAY:C228($arrayPtr->; 1; $pos)
	End if 
End if   // ASSERT

