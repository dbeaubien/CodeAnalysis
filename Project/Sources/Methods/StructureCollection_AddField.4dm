//%attributes = {"invisible":true,"preemptive":"capable"}
// StructureCollection_AddField (structureCollection, fieldObj)
// StructureCollection_AddField (collection, object)
//
// DESCRIPTION
//   Adds a table object to the collection.
//   Ensures that there are no duplicates.
//
C_COLLECTION:C1488($1; $structureCollection)
C_OBJECT:C1216($2; $fieldObj)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/26/2020)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=2))
	$structureCollection:=$1
	$fieldObj:=$2
	
	C_LONGINT:C283($tableNo)
	C_LONGINT:C283($fieldNo)
	C_TEXT:C284($fieldName)
	$tableNo:=$fieldObj.tNo
	$fieldNo:=$fieldObj.fNo
	$fieldName:=$fieldObj.fName
	
	ASSERT:C1129($structureCollection#Null:C1517)
	
	If ($structureCollection.query("fName = :1"; $fieldName).length=0)
		C_OBJECT:C1216($o)
		$o:=New object:C1471
		$o.tableNo:=$tableNo
		$o.fieldNo:=$fieldNo
		$o.fieldName:=$fieldName
		$structureCollection:=$structureCollection.push($o)
	End if 
	
End if 