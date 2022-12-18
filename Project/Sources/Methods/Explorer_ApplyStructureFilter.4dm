//%attributes = {"invisible":true}
// Explorer_ApplyStructureFilter (parm1, parm2) : result
// Explorer_ApplyStructureFilter (parm1, parm2) : result
//
// DESCRIPTION
//   
//
C_OBJECT:C1216($1; $formObj)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/23/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
If (Count parameters:C259=1)
	$formObj:=$1
End if 

$formObj.filteredStructureList:=$formObj.fullStructureList.query("table = :1 OR field = :1"; vStructureFilter+"@")
