//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodLine_StoreMethodsCalled (array of tokens; knownCalledMethods; arrayOfMethodNames) 
// 
// DESCRIPTION
//   Scans the list of tokens and appends any method names to the
//   list of knownCalledMethods. This is done based on the array
//   of method names that is passed in.
//
#DECLARE($tokenArrPtr : Pointer\
; $knownCalledMethods : Text\
; $arrayOfMethodNames : Pointer) : Text
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	
	If ($knownCalledMethods="")
		$knownCalledMethods:=","
	End if 
	
	var $vl_tokenNo : Integer
	For ($vl_tokenNo; 1; Size of array:C274($tokenArrPtr->))
		
		If (Find in array:C230($arrayOfMethodNames->; $tokenArrPtr->{$vl_tokenNo})>0)
			
			If (Position:C15(","+$tokenArrPtr->{$vl_tokenNo}+","; $knownCalledMethods)<1)
				$knownCalledMethods:=$knownCalledMethods+$tokenArrPtr->{$vl_tokenNo}+","
			End if 
			
		End if 
		
	End for 
	
End if 

return $knownCalledMethods