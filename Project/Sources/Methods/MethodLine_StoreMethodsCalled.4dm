//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodLine_StoreMethodsCalled (array of tokens; knownCalledMethods; arrayOfMethodNames) 
// MethodLine_StoreMethodsCalled (pointer; text; pointer) 
// 
// DESCRIPTION
//   Scans the list of tokens and appends any method names to the
//   list of knownCalledMethods. This is done based on the array
//   of method names that is passed in.
//
C_POINTER:C301($1; $tokenArrPtr)
C_TEXT:C284($2; $knownCalledMethods)
C_POINTER:C301($3; $arrayOfMethodNames)
C_TEXT:C284($0)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (08/23/2017)
// ----------------------------------------------------

$knownCalledMethods:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$tokenArrPtr:=$1
	$knownCalledMethods:=$2
	$arrayOfMethodNames:=$3
	
	If ($knownCalledMethods="")
		$knownCalledMethods:=","
	End if 
	
	C_LONGINT:C283($vl_tokenNo)
	For ($vl_tokenNo; 1; Size of array:C274($tokenArrPtr->))
		
		If (Find in array:C230($arrayOfMethodNames->; $tokenArrPtr->{$vl_tokenNo})>0)
			
			If (Position:C15(","+$tokenArrPtr->{$vl_tokenNo}+","; $knownCalledMethods)<1)
				$knownCalledMethods:=$knownCalledMethods+$tokenArrPtr->{$vl_tokenNo}+","
			End if 
			
		End if 
		
	End for 
	
End if   // ASSERT
$0:=$knownCalledMethods