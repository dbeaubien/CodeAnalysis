//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodLine_PushMethodsCalled (array of tokens; arrayOfMethodNames; methodNameCollection) : updatedMethodNameCollection 
// MethodLine_PushMethodsCalled (pointer; pointer; collection) : collection 
// 
// DESCRIPTION
//   Scans the list of tokens and appends any method names to the
//   list of knownCalledMethods. This is done based on the array
//   of method names that is passed in.
//
C_POINTER:C301($1; $tokenArrPtr)
C_POINTER:C301($2; $arrayOfMethodNames)
C_COLLECTION:C1488($3; $methodNameCollection)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/29/2020) - 
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=3))
	$tokenArrPtr:=$1
	$arrayOfMethodNames:=$2
	$methodNameCollection:=$3
	
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($tokenArrPtr->))
		If (Find in array:C230($arrayOfMethodNames->; $tokenArrPtr->{$i})>0)
			$methodNameCollection:=$methodNameCollection.push($tokenArrPtr->{$i})
		End if 
	End for 
	
End if 
