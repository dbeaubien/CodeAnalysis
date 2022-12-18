//%attributes = {"invisible":true,"preemptive":"capable"}
// Array_TrimLeadingSpaces (textArrayPtr)
// Array_TrimLeadingSpaces (pointer)
// 
// DESCRIPTION
//   Goes through each element in the text array and removes
//   any leading spaces.
//
C_POINTER:C301($1; $textArrayPtr)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (06/13/2017)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=1))
	ASSERT:C1129(Type:C295($1->)=Text array:K8:16)
	$textArrayPtr:=$1
	
	// Comment Line
	If (Size of array:C274($textArrayPtr->)>0)
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274($textArrayPtr->))
			If ($textArrayPtr->{$i}=" @")
				$textArrayPtr->{$i}:=STR_Remove_Leading_Spaces($textArrayPtr->{$i})
			End if 
		End for 
	End if 
	
End if 
