//%attributes = {"invisible":true}
// Structure_GetFieldIndexType (tableNo; fieldNo) : indexTypeCode
// Structure_GetFieldIndexType (longint; longint) : longint
// 
// DESCRIPTION
//   Returns the code of the index type for the specified
//   field.
//
C_LONGINT:C283($0; $vl_indexType)
C_LONGINT:C283($1; $vl_tableNo)
C_LONGINT:C283($2; $vl_fieldNo)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (05/19/2015)
// ----------------------------------------------------

Logging_Method_START(Current method name:C684)
$vl_indexType:=0
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$vl_tableNo:=$1
	$vl_fieldNo:=$2
	
	C_BOOLEAN:C305(_INDX_hasInitd)
	If (Not:C34(_INDX_hasInitd))
		_INDX_hasInitd:=True:C214
		
		ARRAY TEXT:C222(at_IndexUUID; 0)
		ARRAY TEXT:C222(at_IndexName; 0)
		ARRAY LONGINT:C221(al_IndexType; 0)
		ARRAY BOOLEAN:C223(ab_IndexUniquness; 0)
		ARRAY LONGINT:C221(al_Col_tableNo; 0)
		ARRAY LONGINT:C221(al_Col_ColumnID; 0)
		ARRAY LONGINT:C221(al_Col_ColumnPositionInIndex; 0)
		Begin SQL
			SELECT indx.Index_ID, indx.Index_Name, indx.Index_Type, indx.Uniqueness,
			col.Table_id, col.Column_ID, col.Column_Position
			FROM _USER_INDEXES indx
			INNER JOIN _USER_IND_COLUMNS col on indx.Index_ID like col.Index_ID
			INTO :at_IndexUUID, :at_IndexName, :al_IndexType, :ab_IndexUniquness,
			:al_Col_tableNo, :al_Col_ColumnID, :al_Col_ColumnPositionInIndex
		End SQL
		SORT ARRAY:C229(al_Col_ColumnID; al_Col_tableNo; at_IndexUUID; at_IndexName; al_IndexType; ab_IndexUniquness; al_Col_ColumnPositionInIndex; >)
	End if 
	
	
	C_LONGINT:C283($j; $vl_count)
	$vl_count:=0
	For ($j; Size of array:C274(at_IndexUUID); 1; -1)
		If (al_Col_tableNo{$j}=$vl_tableNo) & (al_Col_ColumnID{$j}=$vl_fieldNo)
			$vl_count:=$vl_count+1
			$vl_indexType:=al_IndexType{$j}
		End if 
	End for 
	
	
	If ($vl_count#1)
		$vl_indexType:=-1  // Multi
	End if 
End if   // ASSERT
$0:=$vl_indexType
Logging_Method_STOP(Current method name:C684)
