//%attributes = {"invisible":true,"preemptive":"capable"}
// Structure_GetFieldIndexType (tableNo; fieldNo) : indexTypeCode
// 
// DESCRIPTION
//   Returns the code of the index type for the specified
//   field.
//
#DECLARE($table_no : Integer; $field_no : Integer)->$index_type : Integer
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$index_type:=0

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


var $j; $count : Integer
$count:=0
For ($j; Size of array:C274(at_IndexUUID); 1; -1)
	If (al_Col_tableNo{$j}=$table_no) & (al_Col_ColumnID{$j}=$field_no)
		$count:=$count+1
		$index_type:=al_IndexType{$j}
	End if 
End for 


If ($count#1)
	$index_type:=-1  // Multi
End if 
