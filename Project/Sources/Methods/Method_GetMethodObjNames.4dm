//%attributes = {"invisible":true}
// Method_GetMethodObjNames (methodObjNamesArrPtr{; onlySharedMethods})
//
// DESCRIPTION
//   Returns a collection
//
C_POINTER:C301($1; $methodObjNamesArrPtr)
C_BOOLEAN:C305($2; $onlySharedMethods)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/30/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259>=1)
ASSERT:C1129(Count parameters:C259<=2)
$methodObjNamesArrPtr:=$1
If (Count parameters:C259=2)
	$onlySharedMethods:=$2
End if 

ARRAY TEXT:C222($methodObjNamesArrPtr->; 0)

MethodStats__Init
OB GET PROPERTY NAMES:C1232(MethodStatsMasterObj; $methodObjNamesArrPtr->)
SORT ARRAY:C229($methodObjNamesArrPtr->; >)

C_LONGINT:C283($pos)
If (Find in sorted array:C1333($methodObjNamesArrPtr->; "object_format_version"; >; $pos))
	DELETE FROM ARRAY:C228($methodObjNamesArrPtr->; $pos; 1)
End if 


If ($onlySharedMethods)  // reduce to only shared methods
	C_LONGINT:C283($i)
	For ($i; Size of array:C274($methodObjNamesArrPtr->); 1; -1)
		If (Not:C34(MethodStatsMasterObj[$methodObjNamesArrPtr->{$i}].is_shared))
			DELETE FROM ARRAY:C228($methodObjNamesArrPtr->; $i; 1)
		End if 
	End for 
End if 
