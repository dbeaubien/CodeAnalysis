//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodLine_PushStructureUsed (array of tokens; collection; collection; collection; collection; collection)
// MethodLine_PushStructureUsed (pointer; text; pointer...)
// 
// DESCRIPTION
//   Returns a string that has all the fields that are used
//   by the tokenized line.
//
C_POINTER:C301($1; $tokenArrPtr)
C_COLLECTION:C1488($2; $tableList)
C_COLLECTION:C1488($3; $fieldList)
C_COLLECTION:C1488($4; $tablesUsedCollection)
C_COLLECTION:C1488($5; $structureUsedCollection)
C_COLLECTION:C1488($6; $indexedFieldsUsedCol)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (08/28/2017)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=6))
	$tokenArrPtr:=$1
	$tableList:=$2
	$fieldList:=$3
	$tablesUsedCollection:=$4
	$structureUsedCollection:=$5
	$indexedFieldsUsedCol:=$6
	
	C_LONGINT:C283($i; $pos)
	C_TEXT:C284($tableName; $fieldName)
	C_COLLECTION:C1488($c)
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
	
End if 