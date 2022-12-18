//%attributes = {"invisible":true,"preemptive":"capable"}
// StructureCollection_AddTable (structureCollection, tableNo, tableName)
// StructureCollection_AddTable (collection, longint, text)
//
// DESCRIPTION
//   Adds a table object to the collection.
//   Ensures that there are no duplicates.
//
C_COLLECTION:C1488($1; $structureCollection)
C_LONGINT:C283($2; $tableNo)
C_TEXT:C284($3; $tableName)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/26/2020)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=3))
	$structureCollection:=$1
	$tableNo:=$2
	$tableName:=$3
	
	ASSERT:C1129($structureCollection#Null:C1517)
	
	If ($structureCollection.query("tableNo = :1"; $tableNo).length=0)
		C_OBJECT:C1216($o)
		$o:=New object:C1471
		$o.tableNo:=$tableNo
		$o.tableName:=$tableName
		$structureCollection:=$structureCollection.push($o)
	End if 
	
End if 