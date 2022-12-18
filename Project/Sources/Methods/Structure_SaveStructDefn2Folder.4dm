//%attributes = {"invisible":true,"shared":true}
// Structure_SaveStructDefn2Folder (fullPathToFileToSaveReport)
// Structure_SaveStructDefn2Folder (text)
//
// DESCRIPTION
//   Exports a report containing the structure definition
//   of the host database to the file specified.
//
C_TEXT:C284($1; $vt_diskFilePath)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/05/2013)
//   Mod: DB (07/29/2015) - Add support for AutoIncrement and AutoGenerate (4Dv14)
//   Mod: DB (08/27/2015) - Converted to C_OBJECT
// ----------------------------------------------------

C_BOOLEAN:C305($vb_isInvisible; $vb_trigSaveNew; $vb_trigSaveRec; $vb_trigDelRec; $vb_trigLoadRec)
C_BOOLEAN:C305($vb_isIndexed; $vb_isUnique; $vb_isInvisible)
C_LONGINT:C283($vl_fieldType; $vl_fieldLength)
C_LONGINT:C283($i; $j; $curMS)
C_OBJECT:C1216($vo_tbl)

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_diskFilePath:=$1
	
	C_PICTURE:C286($vg_icon)
	READ PICTURE FILE:C678(LibraryImage_GetPlatformPath("Progress_Write.png"); $vg_icon)
	
	C_LONGINT:C283($progHdl)
	$progHdl:=Progress New
	Progress SET TITLE($progHdl; "Exporting table definitions"; 0; "Initializing..."; True:C214)
	Progress SET ICON($progHdl; $vg_icon)
	
	// Get file system to a know state
	Folder_VerifyExistance(Folder_ParentName($vt_diskFilePath))
	File_Delete($vt_diskFilePath)
	
	If (True:C214)  // Gather the basic table data and prime the object
		ARRAY LONGINT:C221($al_tableNo; 0)
		ARRAY TEXT:C222($at_tableName; 0)
		ARRAY BOOLEAN:C223($ab_isReplicationTbl; 0)
		ARRAY BOOLEAN:C223($ab_isRestAvailableTbl; 0)
		ARRAY BOOLEAN:C223($ab_isLoggedTbl; 0)
		Begin SQL
			SELECT TABLE_ID, TABLE_NAME, REPLICATION, REST_AVAILABLE, LOGGED
			FROM _USER_TABLES
			INTO :$al_tableNo, :$at_tableName, :$ab_isReplicationTbl, :$ab_isRestAvailableTbl, :$ab_isLoggedTbl;
		End SQL
		SORT ARRAY:C229($at_tableName; $al_tableNo; $ab_isReplicationTbl; $ab_isRestAvailableTbl; $ab_isLoggedTbl; >)
		
		ARRAY OBJECT:C1221($vo_tables; Size of array:C274($at_tableName))
		For ($i; 1; Size of array:C274($at_tableName))
			GET TABLE PROPERTIES:C687($al_tableNo{$i}; $vb_isInvisible; $vb_trigSaveNew; $vb_trigSaveRec; $vb_trigDelRec; $vb_trigLoadRec)
			
			$vo_tables{$i}:=New object:C1471
			$vo_tables{$i}.TableNo:=$al_tableNo{$i}
			$vo_tables{$i}.TableName:=$at_tableName{$i}
			$vo_tables{$i}.Invisible:=$vb_isInvisible
			$vo_tables{$i}.Replication:=$ab_isReplicationTbl{$i}
			$vo_tables{$i}.IncludedInLogFile:=$ab_isLoggedTbl{$i}
			$vo_tables{$i}.RestAvailable:=$ab_isRestAvailableTbl{$i}
			$vo_tables{$i}.TriggerNewRecord:=$vb_trigSaveNew
			$vo_tables{$i}.TriggerSaveRecord:=$vb_trigSaveRec
			$vo_tables{$i}.TriggerDelRecord:=$vb_trigDelRec
			$vo_tables{$i}.TriggerLoadRecord:=$vb_trigLoadRec
			$vo_tables{$i}.FieldCount:=0
		End for 
	End if 
	
	
	If (True:C214)  // Gather the basic field data
		ARRAY LONGINT:C221($al_fieldTableNo; 0)
		ARRAY LONGINT:C221($al_fieldNo; 0)
		ARRAY LONGINT:C221($al_dataType; 0)
		ARRAY INTEGER:C220($al_oldDataType; 0)
		ARRAY TEXT:C222($at_fieldName; 0)
		ARRAY BOOLEAN:C223($ab_isNullable; 0)
		ARRAY BOOLEAN:C223($ab_doAutoGenerate; 0)  // Mod: DB (07/29/2015) - 4Dv14
		ARRAY BOOLEAN:C223($ab_doAutoIncrement; 0)  // Mod: DB (07/29/2015) - 4Dv14
		ARRAY BOOLEAN:C223($ab_isRestAvailableFld; 0)  // Mod: DB (07/29/2015) - 4Dv14
		Begin SQL
			-- _USER_COLUMNS
			SELECT Table_ID, Column_ID, Data_Type, Old_Data_Type, Column_Name, Nullable, AutoGenerate, AutoIncrement, Rest_Available
			FROM _USER_COLUMNS
			ORDER BY Table_ID asc, Column_ID asc
			INTO :$al_fieldTableNo, :$al_fieldNo, :$al_dataType, :$al_oldDataType, :$at_fieldName, :$ab_isNullable, :$ab_doAutoGenerate, :$ab_doAutoIncrement, :$ab_isRestAvailableFld;
		End SQL
		
		C_LONGINT:C283($vl_tableNo)
		$vl_tableNo:=0
		For ($i; 1; Size of array:C274($al_fieldTableNo))
			If ($vl_tableNo#$al_fieldTableNo{$i})
				ARRAY OBJECT:C1221($ao_fields; 0)
				$vl_tableNo:=$al_fieldTableNo{$i}
				$vo_tbl:=$vo_tables{Find in array:C230($al_tableNo; $vl_tableNo)}
			End if 
			
			GET FIELD PROPERTIES:C258($vl_tableNo; $al_fieldNo{$i}; $vl_fieldType; $vl_fieldLength; $vb_isIndexed; $vb_isUnique; $vb_isInvisible)
			
			C_OBJECT:C1216($vo_fld)
			$vo_fld:=New object:C1471
			$vo_fld.FieldNo:=$al_fieldNo{$i}
			$vo_fld.FieldName:=$at_fieldName{$i}
			$vo_fld.Invisible:=$vb_isInvisible
			$vo_fld.Unique:=$vb_isUnique
			$vo_fld.Nullable:=$ab_isNullable{$i}
			$vo_fld.AutoGenerate:=$ab_doAutoGenerate{$i}
			$vo_fld.AutoIncrement:=$ab_doAutoIncrement{$i}
			$vo_fld.RestAvailable:=$ab_isRestAvailableFld{$i}
			$vo_fld.FieldType_4D_AsNum:=$vl_fieldType
			$vo_fld.FieldType_4D_AsText:=Structure__DataType2String($vl_fieldType)
			$vo_fld.FieldType_SQL_AsNum:=$al_dataType{$i}
			$vo_fld.FieldType_SQL_AsText:=Structure__SQLDataType2String($al_dataType{$i})
			$vo_fld.FieldLength:=$vl_fieldLength
			APPEND TO ARRAY:C911($ao_fields; $vo_fld)
			
			$vo_tbl.FieldCount:=$vo_tbl.FieldCount+1
			
			Case of 
				: ($i=Size of array:C274($al_fieldTableNo))
					OB SET ARRAY:C1227($vo_tbl; "Fields"; $ao_fields)
				: ($vl_tableNo#$al_fieldTableNo{$i+1})
					OB SET ARRAY:C1227($vo_tbl; "Fields"; $ao_fields)
				Else 
					// continue on
			End case 
		End for 
		
	End if 
	
	
	If (True:C214)  // Gather the basic index data
		// Grab the indexes that are defined 
		ARRAY TEXT:C222($at_IndexUUID; 0)
		ARRAY TEXT:C222($at_IndexName; 0)
		ARRAY LONGINT:C221($al_IndexType; 0)
		ARRAY BOOLEAN:C223($ab_IndexKeyword; 0)
		ARRAY BOOLEAN:C223($ab_IndexUniquness; 0)
		ARRAY LONGINT:C221($al_Col_tableNo; 0)
		ARRAY LONGINT:C221($al_Col_fieldNo; 0)
		ARRAY LONGINT:C221($al_Col_ColumnPositionInIndex; 0)
		Begin SQL
			-- _USER_INDEXES and _USER_IND_COLUMNS
			SELECT indx.Index_ID, indx.Index_Name, cols.Column_Position, indx.Index_Type, indx.Keyword, indx.Uniqueness, cols.Table_id, cols.Column_ID
			FROM _USER_IND_COLUMNS as 'cols', _USER_INDEXES as 'indx'
			WHERE (indx.INDEX_ID = cols.INDEX_ID)
			ORDER BY cols.TABLE_ID ASC, cols.INDEX_ID ASC, cols.COLUMN_POSITION ASC
			INTO :$at_IndexUUID, :$at_IndexName, :$al_Col_ColumnPositionInIndex, :$al_IndexType, :$ab_IndexKeyword, :$ab_IndexUniquness, :$al_Col_tableNo, :$al_Col_fieldNo;
		End SQL
		
		C_TEXT:C284($indexId)
		$indexId:=""
		For ($i; 1; Size of array:C274($al_Col_tableNo))
			If ($vl_tableNo#$al_Col_tableNo{$i})
				ARRAY OBJECT:C1221($ao_indexes; 0)
				$vl_tableNo:=$al_Col_tableNo{$i}
				$vo_tbl:=$vo_tables{Find in array:C230($al_tableNo; $vl_tableNo)}
			End if 
			
			C_OBJECT:C1216($vo_index)
			If ($indexId#$at_IndexUUID{$i})
				$indexId:=$at_IndexUUID{$i}
				$vo_index:=New object:C1471
				APPEND TO ARRAY:C911($ao_indexes; $vo_index)
				
				If ($at_IndexName{$i}#"")
					$vo_index.IndexName:=$at_IndexName{$i}
				End if 
				$vo_index.IndexType:=Structure_IndexType2Name($al_IndexType{$i})
				$vo_index.Uniqueness:=$ab_IndexUniquness{$i}
				$vo_index.Keyword:=$ab_IndexKeyword{$i}
				$vo_index.Fields:=New collection:C1472
			End if 
			$vo_index.Fields.push($al_Col_fieldNo{$i})
			
			
			Case of 
				: ($i=Size of array:C274($al_Col_tableNo))
					OB SET ARRAY:C1227($vo_tbl; "Indexes"; $ao_indexes)
				: ($vl_tableNo#$al_Col_tableNo{$i+1})
					OB SET ARRAY:C1227($vo_tbl; "Indexes"; $ao_indexes)
				Else 
					// continue on
			End case 
		End for 
	End if 
	
	
	C_OBJECT:C1216($structureExportObj)
	OB SET ARRAY:C1227($structureExportObj; "Tables"; $vo_tables)
	
	C_TEXT:C284($textToExport)
	$textToExport:=JSON Stringify:C1217($structureExportObj; *)
	
	C_TEXT:C284($vt_EOL_Target; $vt_EOL_Current)
	$vt_EOL_Target:=Pref_GetEOL
	$vt_EOL_Current:=STR_TellMeTheEOL($textToExport)
	
	If ($vt_EOL_Current#$vt_EOL_Target)
		$textToExport:=Replace string:C233($textToExport; $vt_EOL_Current; $vt_EOL_Target)
	End if 
	
	C_TIME:C306($docRef)
	$docRef:=Create document:C266($vt_diskFilePath)  // Don't use "TEXT TO DOCUMENT", that changes eol chars
	If (OK=1)
		SEND PACKET:C103($docRef; $textToExport)
		CLOSE DOCUMENT:C267($docRef)
	End if 
	
	Progress QUIT($progHdl)
End if   // ASSERT