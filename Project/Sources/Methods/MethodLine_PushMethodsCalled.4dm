//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodLine_PushMethodsCalled (array of tokens; arrayOfMethodNames; methodNameCollection) : updatedMethodNameCollection 
// 
// DESCRIPTION
//   Scans the list of tokens and appends any method names to the
//   list of knownCalledMethods. This is done based on the array
//   of method names that is passed in.
//
#DECLARE($tokenArrPtr : Pointer\
; $arrayOfMethodNames : Pointer\
; $methodNameCollection : Collection)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=3))
	
	var $i : Integer
	For ($i; 1; Size of array:C274($tokenArrPtr->))
		If (Find in array:C230($arrayOfMethodNames->; $tokenArrPtr->{$i})>0)
			$methodNameCollection:=$methodNameCollection.push($tokenArrPtr->{$i})
		End if 
	End for 
	
End if 
