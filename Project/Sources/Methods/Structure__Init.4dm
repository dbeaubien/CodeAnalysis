//%attributes = {"invisible":true,"preemptive":"capable"}
// Structure__Init () 
//
// DESCRIPTION
//   
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (02/25/2017)
// ----------------------------------------------------


C_BOOLEAN:C305(_structureInitd)
If (Not:C34(_structureInitd))
	_structureInitd:=True:C214
	
	// Build up our arrays
	ARRAY TEXT:C222($at_TBL_tableNames; 0)
	ARRAY LONGINT:C221($al_TBL_tableNos; 0)
	ARRAY TEXT:C222($at_FLD_tableFieldNames; 0)
	ARRAY POINTER:C280($ap_FLD_fieldPtrs; 0)
	ARRAY BOOLEAN:C223($ab_FLD_hasIndex; 0)
	
	// Build arrays for table names and arrays for field info
	C_LONGINT:C283($vl_fieldType; $vl_fieldLength; $tableNo; $fieldNo)
	C_BOOLEAN:C305($vb_isIndexed)
	C_COLLECTION:C1488($tableCol; $fieldCol)
	C_TEXT:C284($tableName; $fieldName)
	$tableCol:=New collection:C1472
	$fieldCol:=New collection:C1472
	For ($tableNo; 1; Get last table number:C254)
		If (Is table number valid:C999($tableNo))
			$tableName:="["+Table name:C256($tableNo)+"]"
			$tableCol.push(New object:C1471("tNo"; $tableNo; "tName"; $tableName))
			APPEND TO ARRAY:C911($at_TBL_tableNames; $tableName)
			APPEND TO ARRAY:C911($al_TBL_tableNos; $tableNo)
			
			// Build an array of table/field names
			For ($fieldNo; 1; Get last field number:C255($tableNo))
				If (Is field number valid:C1000($tableNo; $fieldNo))
					$fieldName:=$tableName+Field name:C257($tableNo; $fieldNo)
					GET FIELD PROPERTIES:C258($tableNo; $fieldNo; $vl_fieldType; $vl_fieldLength; $vb_isIndexed)  // need to know if it is indexed
					APPEND TO ARRAY:C911($at_FLD_tableFieldNames; $fieldName)
					APPEND TO ARRAY:C911($ap_FLD_fieldPtrs; Field:C253($tableNo; $fieldNo))
					APPEND TO ARRAY:C911($ab_FLD_hasIndex; $vb_isIndexed)
					$fieldCol.push(New object:C1471("tNo"; $tableNo; "fNo"; $fieldNo; "fName"; $fieldName; "indexed"; $vb_isIndexed))
				End if 
			End for 
			
		End if 
	End for 
	
	
	C_OBJECT:C1216(_STRUCT_ObjOfArrays)
	_STRUCT_ObjOfArrays:=New object:C1471
	OB SET ARRAY:C1227(_STRUCT_ObjOfArrays; "tableNames"; $at_TBL_tableNames)
	OB SET ARRAY:C1227(_STRUCT_ObjOfArrays; "tableNos"; $al_TBL_tableNos)
	OB SET ARRAY:C1227(_STRUCT_ObjOfArrays; "tableFieldNames"; $at_FLD_tableFieldNames)
	OB SET ARRAY:C1227(_STRUCT_ObjOfArrays; "fieldPtrs"; $ap_FLD_fieldPtrs)
	OB SET ARRAY:C1227(_STRUCT_ObjOfArrays; "fieldIsIndexed"; $ab_FLD_hasIndex)
	_STRUCT_ObjOfArrays.tableList:=$tableCol
	_STRUCT_ObjOfArrays.fieldList:=$fieldCol
	
End if 



