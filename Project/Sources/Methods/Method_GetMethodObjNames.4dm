//%attributes = {"invisible":true}
// Method_GetMethodObjNames (methodObjNamesArrPtr{; onlySharedMethods})
//
// DESCRIPTION
//   Returns a collection
//
#DECLARE($methodObjNamesArrPtr : Pointer; $onlySharedMethods : Boolean)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259>=1)
ASSERT:C1129(Count parameters:C259<=2)

ARRAY TEXT:C222($methodObjNamesArrPtr->; 0)

MethodStats__Init
OB GET PROPERTY NAMES:C1232(MethodStatsMasterObj; $methodObjNamesArrPtr->)
SORT ARRAY:C229($methodObjNamesArrPtr->; >)

var $pos : Integer
If (Find in sorted array:C1333($methodObjNamesArrPtr->; "object_format_version"; >; $pos))
	DELETE FROM ARRAY:C228($methodObjNamesArrPtr->; $pos; 1)
End if 


If ($onlySharedMethods)  // reduce to only shared methods
	var $i : Integer
	For ($i; Size of array:C274($methodObjNamesArrPtr->); 1; -1)
		If (Not:C34(MethodStatsMasterObj[$methodObjNamesArrPtr->{$i}].is_shared))
			DELETE FROM ARRAY:C228($methodObjNamesArrPtr->; $i; 1)
		End if 
	End for 
End if 
