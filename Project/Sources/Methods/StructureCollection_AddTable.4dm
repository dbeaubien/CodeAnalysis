//%attributes = {"invisible":true,"preemptive":"capable"}
// StructureCollection_AddTable (structureCollection, tableNo, tableName)
//
// DESCRIPTION
//   Adds a table object to the collection.
//   Ensures that there are no duplicates.
//
#DECLARE($structureCollection : Collection\
; $tableNo : Integer\
; $tableName : Text)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=3)
ASSERT:C1129($structureCollection#Null:C1517)

If ($structureCollection.query("tableNo = :1"; $tableNo).length=0)
	var $o : Object
	$o:=New object:C1471
	$o.tableNo:=$tableNo
	$o.tableName:=$tableName
	$structureCollection:=$structureCollection.push($o)
End if 
