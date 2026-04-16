//%attributes = {"invisible":true,"preemptive":"capable"}
// Array_TrimLeadingSpaces (textArrayPtr)
// 
// DESCRIPTION
//   Goes through each element in the text array and removes
//   any leading spaces.
//
#DECLARE($textArrayPtr : Pointer)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=1))
	ASSERT:C1129(Type:C295($textArrayPtr->)=Text array:K8:16)
	
	// Comment Line
	If (Size of array:C274($textArrayPtr->)>0)
		var $i : Integer
		For ($i; 1; Size of array:C274($textArrayPtr->))
			If ($textArrayPtr->{$i}=" @")
				$textArrayPtr->{$i}:=STR_Remove_Leading_Spaces($textArrayPtr->{$i})
			End if 
		End for 
	End if 
	
End if 
