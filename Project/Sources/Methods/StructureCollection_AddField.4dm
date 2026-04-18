//%attributes = {"invisible":true,"preemptive":"capable"}
// StructureCollection_AddField (structureCollection, fieldObj)
//
// DESCRIPTION
//   Adds a table object to the collection.
//   Ensures that there are no duplicates.
//
#DECLARE($structureCollection : Collection; $fieldObj : Object)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
ASSERT:C1129($structureCollection#Null:C1517)

var $tableNo : Integer
var $fieldNo : Integer
var $fieldName : Text
$tableNo:=$fieldObj.tNo
$fieldNo:=$fieldObj.fNo
$fieldName:=$fieldObj.fName

If ($structureCollection.query("fName = :1"; $fieldName).length=0)
	var $o : Object
	$o:=New object:C1471
	$o.tableNo:=$tableNo
	$o.fieldNo:=$fieldNo
	$o.fieldName:=$fieldName
	$structureCollection:=$structureCollection.push($o)
End if 
