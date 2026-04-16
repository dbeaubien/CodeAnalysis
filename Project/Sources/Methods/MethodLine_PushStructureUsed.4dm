//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodLine_PushStructureUsed (array of tokens; collection; collection; collection; collection; collection)
// 
// DESCRIPTION
//   Returns a string that has all the fields that are used
//   by the tokenized line.
//
#DECLARE($tokenArrPtr : Pointer\
; $tableList : Collection\
; $fieldList : Collection\
; $tablesUsedCollection : Collection\
; $structureUsedCollection : Collection\
; $indexedFieldsUsedCol : Collection)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=6)

var $i; $pos : Integer
var $tableName; $fieldName : Text
var $c : Collection
For ($i; 1; Size of array:C274($tokenArrPtr->))
	$tableName:=""
	$fieldName:=""
	
	Case of 
		: ($tokenArrPtr->{$i}="[[")  // short circuit to ignore this token
		: ($tokenArrPtr->{$i}#"[@")  // short circuit to ignore this token
			
		: ($tokenArrPtr->{$i}="@]")  // Is a table name
			$tableName:=$tokenArrPtr->{$i}
			$c:=$tableList.query("tName = :1"; $tableName)
			If ($c.length=1)  // Is a valid table name?
				StructureCollection_AddTable($tablesUsedCollection; $c[0].tNo; $tableName)
			End if 
			
		Else 
			$fieldName:=$tokenArrPtr->{$i}
			$c:=$fieldList.query("fName = :1"; $fieldName)
			If ($c.length=1)  // Is a valid field name?
				$tableName:=Substring:C12($fieldName; 1; Position:C15("]"; $fieldName))  // extract the table name
				StructureCollection_AddTable($tablesUsedCollection; $c[0].tNo; $tableName)
				StructureCollection_AddField($structureUsedCollection; $c[0])
				If ($c[0].indexed)
					StructureCollection_AddField($indexedFieldsUsedCol; $c[0])
				End if 
			End if 
			
	End case 
	
End for 
