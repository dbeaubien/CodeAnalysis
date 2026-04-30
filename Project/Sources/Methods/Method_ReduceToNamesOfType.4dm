//%attributes = {}
// Method_ReduceToNamesOfType (methodPathsArrPtr, typeOfMethod)
//
// DESCRIPTION
//   Reduces the array of method paths down to just those
//   that match the typeOfMethod that the callers wants.
//
#DECLARE($methodPathsArrPtr : Pointer; $typeOfMethod : Text)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

var $i : Integer
For ($i; Size of array:C274($methodPathsArrPtr->); 1; -1)
	If ($typeOfMethod#Method_GetTypeFromPath($methodPathsArrPtr->{$i}))
		DELETE FROM ARRAY:C228($methodPathsArrPtr->; $i; 1)
	End if 
End for 
