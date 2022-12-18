//%attributes = {}
// Method_ReduceToNamesOfType (methodPathsArrPtr, typeOfMethod)
//
// DESCRIPTION
//   Reduces the array of method paths down to just those
//   that match the typeOfMethod that the callers wants.
//
C_POINTER:C301($1; $methodPathsArrPtr)
C_TEXT:C284($2; $typeOfMethod)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/30/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$methodPathsArrPtr:=$1
$typeOfMethod:=$2

C_LONGINT:C283($i)
For ($i; Size of array:C274($methodPathsArrPtr->); 1; -1)
	If ($typeOfMethod#Method_GetTypeFromPath($methodPathsArrPtr->{$i}))
		DELETE FROM ARRAY:C228($methodPathsArrPtr->; $i; 1)
	End if 
End for 
