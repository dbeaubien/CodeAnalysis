//%attributes = {"invisible":true,"preemptive":"capable"}
//================================================================================
//@xdoc-start : en
//@name : UTL_structure2Object
//@scope : private 
//@deprecated : no
//@description : This function converts the XML structure exported by "EXPORT STRUCTURE" command into an object
//@parameter[0-OUT-structureObj-OBJECT] : structure object
//@parameter[1-IN-structureXml-TEXT] : structure xml
//@notes : 
//@example : 
//
//  C_TEXT($catalog_xml)
//  EXPORT STRUCTURE($catalog_xml)
//
//  C_OBJECT($vo_structure)
//  $vo_structure:=UTL_structure2Object($catalog_xml)
//
//  SET TEXT TO PASTEBOARD(JSON Stringify($vo_structure))
//
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE)) - Copyrights A&C Consulting 2023
//@history : 
//  CREATION : Bruno LEGAY (BLE)) - 14/04/2023, 09:05:58 - 4.00.01
//@xdoc-end
//================================================================================
// REFERENCE: https://discuss.4d.com/t/structure-to-object/27154
//================================================================================
#DECLARE($catalog_xml : Text)->$structure_model : Object
//================================================================================
ASSERT:C1129(Count parameters:C259>0; "requires 1 parameter")
$structure_model:={\
tables: []; \
tables_by_no: {}; \
schemas: []}

var $root_DOM_ref : Text
$root_DOM_ref:=DOM Parse XML variable:C720($catalog_xml)
If (OK#1)
	return 
End if 

var $dummy_DOM_ref : Text
var $attribute_index : Integer
var $attribute_name; $attribute_value : Text

If (True:C214)  // schema
	ARRAY TEXT:C222($tt_schemaElementDomRef; 0)
	$dummy_DOM_ref:=DOM Find XML element:C864($root_DOM_ref; "/base/schema"; $tt_schemaElementDomRef)
	If (OK=1)
		var $i : Integer
		For ($i; 1; Size of array:C274($tt_schemaElementDomRef))
			DOM GET XML ATTRIBUTE BY NAME:C728($tt_schemaElementDomRef{$i}\
				; "name"; $attribute_value)
			$structure_model.schemas.push({name: $attribute_value})
		End for 
	End if 
	ARRAY TEXT:C222($tt_schemaElementDomRef; 0)
End if 

If (True:C214)  // table
	ARRAY TEXT:C222($tt_tableElementDomRef; 0)
	$dummy_DOM_ref:=DOM Find XML element:C864($root_DOM_ref; "/base/table"; $tt_tableElementDomRef)
	If (ok=1)
		ARRAY LONGINT:C221($tl_tableNo; Size of array:C274($tt_tableElementDomRef))
		ARRAY TEXT:C222($tt_tableName; Size of array:C274($tt_tableElementDomRef))
		ARRAY OBJECT:C1221($to_tables; 0)
		For ($i; 1; Size of array:C274($tt_tableElementDomRef))
			C_TEXT:C284($vt_tableElementDomRef)
			$vt_tableElementDomRef:=$tt_tableElementDomRef{$i}
			
			C_OBJECT:C1216($vo_table)
			
			If (True:C214)  // read the table properties
				For ($attribute_index; 1; DOM Count XML attributes:C727($vt_tableElementDomRef))
					DOM GET XML ATTRIBUTE BY INDEX:C729($vt_tableElementDomRef; $attribute_index; $attribute_name; $attribute_value)
					Case of 
						: ($attribute_name="id")
							OB SET:C1220($vo_table; $attribute_name; Num:C11($attribute_value))
							
						: ($attribute_name="sql_schema_id")
							OB SET:C1220($vo_table; "sqlSchemaId"; Num:C11($attribute_value))
							
						: ($attribute_name="sql_schema_name")
							OB SET:C1220($vo_table; "sqlSchemaName"; $attribute_value)
							
						: (($attribute_name="uuid") | ($attribute_name="name"))
							OB SET:C1220($vo_table; $attribute_name; $attribute_value)
							
						: (($attribute_value="true") | ($attribute_value="false"))  // "prevent_journaling", "leave_tag_on_delete"
							OB SET:C1220($vo_table; UTL_lowerCamelCase($attribute_name); $attribute_value="true")
							
						Else 
							OB SET:C1220($vo_table; UTL_lowerCamelCase($attribute_name); $attribute_value)
					End case 
				End for 
			End if 
			
			
			If (True:C214)  // read the trigger properties table/table_extra
				C_OBJECT:C1216($vo_triggers)
				var $vt_tableExtraDomRef : Text
				$vt_tableExtraDomRef:=DOM Find XML element:C864($vt_tableElementDomRef; "table_extra")
				If (OK#1)
					$vt_tableExtraDomRef:=""
				End if 
				
				If ($vt_tableExtraDomRef#"")
					// Read the comment of the table
					ARRAY TEXT:C222($tt_commentElementDomRef; 0)
					$dummy_DOM_ref:=DOM Find XML element:C864($vt_tableExtraDomRef; "comment"; $tt_commentElementDomRef)
					If (OK=1)
						C_LONGINT:C283($vl_commentIndex)
						For ($vl_commentIndex; 1; Size of array:C274($tt_commentElementDomRef))
							
							C_TEXT:C284($vt_format; $vt_comment; $vt_commentCData)
							$vt_format:=""
							$vt_comment:=""
							$vt_commentCData:=""
							DOM GET XML ATTRIBUTE BY NAME:C728($tt_commentElementDomRef{$vl_commentIndex}; "format"; $vt_format)
							DOM GET XML ELEMENT VALUE:C731($tt_commentElementDomRef{$vl_commentIndex}; $vt_comment; $vt_commentCData)
							If (Length:C16($vt_comment)=0)
								$vt_comment:=$vt_commentCData
							End if 
							
							Case of 
								: (($vt_format="rtf") | ($vt_comment="{\\rtf@}"))
									OB SET:C1220($vo_table; "commentRtf"; $vt_comment)
									
									//C_TEXT($vt_commentBrut)
									//$vt_commentBrut:=ST Get plain text($vt_comment)
									//If (Length($vt_commentBrut)>0)
									//OB SET($vo_table; "comment"; $vt_commentBrut)
									//End if 
									OB SET:C1220($vo_table; "comment"; $vt_comment)
									
								: ($vt_format="text")
									OB SET:C1220($vo_table; "comment"; $vt_comment)
									
							End case 
							$vt_format:=""
							$vt_comment:=""
							$vt_commentCData:=""
						End for 
					End if 
					ARRAY TEXT:C222($tt_commentElementDomRef; 0)
					
					
					For ($attribute_index; 1; DOM Count XML attributes:C727($vt_tableExtraDomRef))
						DOM GET XML ATTRIBUTE BY INDEX:C729($vt_tableExtraDomRef; $attribute_index; $attribute_name; $attribute_value)
						Case of 
							: (($attribute_name="visible") | ($attribute_name="trashed"))
								OB SET:C1220($vo_table; $attribute_name; $attribute_value="true")
								
							: ($attribute_name="trigger_load")
								OB SET:C1220($vo_triggers; "onLoad"; $attribute_value="true")
								
							: ($attribute_name="trigger_insert")
								OB SET:C1220($vo_triggers; "onInsert"; $attribute_value="true")
								
							: ($attribute_name="trigger_update")
								OB SET:C1220($vo_triggers; "onUpdate"; $attribute_value="true")
								
							: ($attribute_name="trigger_delete")
								OB SET:C1220($vo_triggers; "onDelete"; $attribute_value="true")
								
						End case 
					End for 
				End if 
				
				OB SET:C1220($vo_table; "triggers"; $vo_triggers)
				CLEAR VARIABLE:C89($vo_triggers)
			End if 
			
			
			If (True:C214)  // primary_key
				ARRAY TEXT:C222($tt_primaryKeyElementDomRef; 0)
				$dummy_DOM_ref:=DOM Find XML element:C864($vt_tableElementDomRef; "primary_key"; $tt_primaryKeyElementDomRef)
				If (ok=1)
					C_LONGINT:C283($vl_nbPrimaryKey)
					$vl_nbPrimaryKey:=Size of array:C274($tt_primaryKeyElementDomRef)
					
					ARRAY OBJECT:C1221($to_primaryKeys; 0)
					
					C_LONGINT:C283($vl_primaryKeyIndex)
					For ($vl_primaryKeyIndex; 1; $vl_nbPrimaryKey)
						C_TEXT:C284($vt_primaryKeyDomRef)
						$vt_primaryKeyDomRef:=$tt_primaryKeyElementDomRef{$vl_primaryKeyIndex}
						
						C_OBJECT:C1216($vo_primaryKey)
						
						For ($attribute_index; 1; DOM Count XML attributes:C727($vt_primaryKeyDomRef))
							DOM GET XML ATTRIBUTE BY INDEX:C729($vt_primaryKeyDomRef; $attribute_index; $attribute_name; $attribute_value)
							OB SET:C1220($vo_primaryKey; UTL_lowerCamelCase($attribute_name); $attribute_value)
						End for 
						
						APPEND TO ARRAY:C911($to_primaryKeys; $vo_primaryKey)
						CLEAR VARIABLE:C89($vo_primaryKey)
					End for 
					
					OB SET ARRAY:C1227($vo_table; "primaryKeys"; $to_primaryKeys)
					ARRAY OBJECT:C1221($to_primaryKeys; 0)
					
				End if 
				ARRAY TEXT:C222($tt_primaryKeyElementDomRef; 0)
				
			End if 
			
			
			If (True:C214)  // read the field properties
				ARRAY TEXT:C222($tt_fieldElementDomRef; 0)
				
				$dummy_DOM_ref:=DOM Find XML element:C864($vt_tableElementDomRef; "field"; $tt_fieldElementDomRef)
				If (ok=1)
					
					C_LONGINT:C283($vl_nbField)
					$vl_nbField:=Size of array:C274($tt_fieldElementDomRef)
					
					ARRAY OBJECT:C1221($to_fields; 0)
					
					C_LONGINT:C283($vl_fieldIndex)
					For ($vl_fieldIndex; 1; $vl_nbField)
						C_TEXT:C284($vt_fieldElementDomRef)
						$vt_fieldElementDomRef:=$tt_fieldElementDomRef{$vl_fieldIndex}
						
						C_OBJECT:C1216($vo_field)
						
						If (True:C214)  // read the field properties
							For ($attribute_index; 1; DOM Count XML attributes:C727($vt_fieldElementDomRef))
								DOM GET XML ATTRIBUTE BY INDEX:C729($vt_fieldElementDomRef; $attribute_index; $attribute_name; $attribute_value)
								Case of 
									: ($attribute_name="id")
										OB SET:C1220($vo_field; $attribute_name; Num:C11($attribute_value))
										
									: (($attribute_name="uuid") | ($attribute_name="name"))
										OB SET:C1220($vo_field; $attribute_name; $attribute_value)
										
									: ($attribute_name="type")
										OB SET:C1220($vo_field; $attribute_name; Num:C11($attribute_value))
										C_TEXT:C284($vt_typeStr)
										$vt_typeStr:=""
										C_LONGINT:C283($vl_type)
										$vl_type:=Num:C11($attribute_value)
										Case of 
											: ($vl_type=1)  // boolean
												$vt_typeStr:="boolean"
												
											: ($vl_type=3)  // integer
												$vt_typeStr:="integer"
												
											: ($vl_type=4)  // longint
												$vt_typeStr:="longint"
												
											: ($vl_type=5)  // longint 64 bits
												$vt_typeStr:="longint64Bits"
												
											: ($vl_type=6)  // real
												$vt_typeStr:="real"
												
											: ($vl_type=7)  // float
												$vt_typeStr:="float"
												
											: ($vl_type=8)  // date
												$vt_typeStr:="date"
												
											: ($vl_type=9)  // heure
												$vt_typeStr:="heure"
												
											: ($vl_type=10)  // alpha
												$vt_typeStr:="alpha"
												
											: ($vl_type=12)  // image
												$vt_typeStr:="image"
												
											: ($vl_type=14)  // text
												$vt_typeStr:="text"
												
											: ($vl_type=18)  // blob
												$vt_typeStr:="blob"
												
											: ($vl_type=21)  // object
												$vt_typeStr:="object"
												
											Else 
												$vt_typeStr:="unknown ("+$attribute_value+")"
												
										End case 
										
										OB SET:C1220($vo_field; "typeStr"; $vt_typeStr)
										
									: ($attribute_name="text_switch_size") | ($attribute_name="blob_switch_size")
										OB SET:C1220($vo_field; UTL_lowerCamelCase($attribute_name); Num:C11($attribute_value))
										
									: (($attribute_value="true") | ($attribute_value="false"))  // "prevent_journaling", "leave_tag_on_delete"
										OB SET:C1220($vo_field; UTL_lowerCamelCase($attribute_name); $attribute_value="true")
										
									Else 
										OB SET:C1220($vo_field; UTL_lowerCamelCase($attribute_name); $attribute_value)
								End case 
							End for 
						End if 
						
						// index_ref
						
						If (True:C214)  // read the field index properties
							C_TEXT:C284($vt_indexDomRef)
							$vt_indexDomRef:=DOM Find XML element:C864($vt_fieldElementDomRef; "index_ref[1]")
							If (ok=1)
								C_TEXT:C284($vt_uuid)
								DOM GET XML ATTRIBUTE BY NAME:C728($vt_indexDomRef; "uuid"; $vt_uuid)
								OB SET:C1220($vo_field; "indexUuid"; $vt_uuid)
							End if 
						End if 
						
						If (True:C214)  // read the field extra properties
							ARRAY TEXT:C222($tt_commentElementDomRef; 0)
							$dummy_DOM_ref:=DOM Find XML element:C864($vt_fieldElementDomRef; "field_extra[1]/comment"; $tt_commentElementDomRef)
							If (ok=1)
								C_LONGINT:C283($vl_commentIndex)
								For ($vl_commentIndex; 1; Size of array:C274($tt_commentElementDomRef))
									
									C_TEXT:C284($vt_format; $vt_comment; $vt_commentCData)
									$vt_format:=""
									$vt_comment:=""
									$vt_commentCData:=""
									DOM GET XML ATTRIBUTE BY NAME:C728($tt_commentElementDomRef{$vl_commentIndex}; "format"; $vt_format)
									DOM GET XML ELEMENT VALUE:C731($tt_commentElementDomRef{$vl_commentIndex}; $vt_comment; $vt_commentCData)
									If (Length:C16($vt_comment)=0)
										$vt_comment:=$vt_commentCData
									End if 
									
									Case of 
										: (($vt_format="rtf") | ($vt_comment="{\\rtf@}"))
											OB SET:C1220($vo_field; "commentRtf"; $vt_comment)
											//C_TEXT($vt_commentBrut)
											//$vt_commentBrut:=ST Get plain text($vt_comment)
											//If (Length($vt_commentBrut)>0)
											//OB SET($vo_field; "comment"; $vt_commentBrut)
											//End if 
											OB SET:C1220($vo_field; "comment"; $vt_comment)
											
										: ($vt_format="text")
											OB SET:C1220($vo_field; "comment"; $vt_comment)
									End case 
									$vt_format:=""
									$vt_comment:=""
									$vt_commentCData:=""
								End for 
							End if 
							ARRAY TEXT:C222($tt_commentElementDomRef; 0)
							
							C_TEXT:C284($vt_tipElementDomRef)
							$vt_tipElementDomRef:=DOM Find XML element:C864($vt_fieldElementDomRef; "field_extra[1]/tip[1]"; $tt_commentElementDomRef)
							If (ok=1)
								C_TEXT:C284($vt_tip; $vt_tipCData)
								$vt_tip:=""
								$vt_tipCData:=""
								DOM GET XML ELEMENT VALUE:C731($vt_tipElementDomRef; $vt_tip; $vt_tipCData)
								If (Length:C16($vt_tip)=0)
									$vt_tip:=$vt_tipCData
								End if 
								OB SET:C1220($vo_field; "tip"; $vt_tip)
								
							End if 
							
							If (True:C214)  // read the field extra attributes
								C_TEXT:C284($vt_extraDomRef)
								$vt_extraDomRef:=DOM Find XML element:C864($vt_fieldElementDomRef; "field_extra[1]"; $tt_commentElementDomRef)
								If (ok=1)  // read the field extra attributes
									For ($attribute_index; 1; DOM Count XML attributes:C727($vt_extraDomRef))
										DOM GET XML ATTRIBUTE BY INDEX:C729($vt_extraDomRef; $attribute_index; $attribute_name; $attribute_value)
										Case of 
											: ($attribute_name="position")
												OB SET:C1220($vo_field; $attribute_name; Num:C11($attribute_value))
												
											: ($attribute_name="enumeration_id")
												OB SET:C1220($vo_field; "enumerationId"; Num:C11($attribute_value))
												
											: (($attribute_value="true") | ($attribute_value="false"))  // "prevent_journaling", "leave_tag_on_delete"
												OB SET:C1220($vo_field; UTL_lowerCamelCase($attribute_name); $attribute_value="true")
												
											Else 
												OB SET:C1220($vo_field; UTL_lowerCamelCase($attribute_name); $attribute_value)
										End case 
									End for 
								End if 
							End if 
							
						End if 
						
						APPEND TO ARRAY:C911($to_fields; $vo_field)
						CLEAR VARIABLE:C89($vo_field)
						
					End for 
					
					
					OB SET ARRAY:C1227($vo_table; "fields"; $to_fields)
					ARRAY OBJECT:C1221($to_fields; 0)
					
				End if 
				ARRAY TEXT:C222($tt_fieldElementDomRef; 0)
			End if 
			
			$structure_model.tables_by_no[String:C10($vo_table.id)]:=$vo_table
			
			APPEND TO ARRAY:C911($to_tables; $vo_table)
			CLEAR VARIABLE:C89($vo_table)
		End for 
		
		OB SET ARRAY:C1227($structure_model; "tables"; $to_tables)
		ARRAY OBJECT:C1221($to_tables; 0)
	End if 
	
	
	ARRAY TEXT:C222($tt_tableElementDomRef; 0)
End if 

If (True:C214)  // relation
	ARRAY TEXT:C222($tt_relationElementDomRef; 0)
	$dummy_DOM_ref:=DOM Find XML element:C864($root_DOM_ref; "/base/relation"; $tt_relationElementDomRef)
	If (ok=1)
		ARRAY OBJECT:C1221($to_relations; 0)
		
		C_LONGINT:C283($vl_relationIndex)
		For ($vl_relationIndex; 1; Size of array:C274($tt_relationElementDomRef))
			C_TEXT:C284($vt_relationDomRef)
			$vt_relationDomRef:=$tt_relationElementDomRef{$vl_relationIndex}
			
			C_OBJECT:C1216($vo_relation)
			For ($attribute_index; 1; DOM Count XML attributes:C727($vt_relationDomRef))
				DOM GET XML ATTRIBUTE BY INDEX:C729($vt_relationDomRef; $attribute_index; $attribute_name; $attribute_value)
				Case of 
					: ($attribute_name="uuid")
						OB SET:C1220($vo_relation; $attribute_name; $attribute_value)
						
					: ($attribute_name="integrity")  // (none | reject | delete)"none"
						OB SET:C1220($vo_relation; $attribute_name; $attribute_value)
						
					: ($attribute_name="state")
						OB SET:C1220($vo_relation; $attribute_name; Num:C11($attribute_value))
						
					: (($attribute_name="auto_load_Nto1") | ($attribute_name="auto_load_1toN") | ($attribute_name="foreign_key"))
						OB SET:C1220($vo_relation; UTL_lowerCamelCase($attribute_name); $attribute_value="true")
						
					: ($attribute_name="name_Nto1")
						OB SET:C1220($vo_relation; $attribute_name; $attribute_value)
						
					: ($attribute_name="name_1toN")
						OB SET:C1220($vo_relation; $attribute_name; $attribute_value)
						
					Else 
						OB SET:C1220($vo_relation; UTL_lowerCamelCase($attribute_name); $attribute_value)
				End case 
			End for 
			
			ARRAY TEXT:C222($tt_relatedFieldElementDomRef; 0)
			$dummy_DOM_ref:=DOM Find XML element:C864($vt_relationDomRef; "related_field"; $tt_relatedFieldElementDomRef)
			If (ok=1)
				
				C_LONGINT:C283($vl_relatedFieldIndex)
				For ($vl_relatedFieldIndex; 1; Size of array:C274($tt_relatedFieldElementDomRef))
					C_TEXT:C284($vt_relatedFieldDomRef)
					$vt_relatedFieldDomRef:=$tt_relatedFieldElementDomRef{$vl_relatedFieldIndex}
					
					C_OBJECT:C1216($vo_relatedField)
					
					C_TEXT:C284($vt_kind)
					DOM GET XML ATTRIBUTE BY NAME:C728($vt_relatedFieldDomRef; "kind"; $vt_kind)
					
					C_TEXT:C284($vt_fieldRefDomRef; $vt_tableRefDomRef)
					C_TEXT:C284($vt_uuid; $vt_name)
					
					$vt_fieldRefDomRef:=DOM Find XML element:C864($vt_relatedFieldDomRef; "field_ref")
					DOM GET XML ATTRIBUTE BY NAME:C728($vt_fieldRefDomRef; "uuid"; $vt_uuid)
					OB SET:C1220($vo_relatedField; "fieldUuid"; $vt_uuid)
					DOM GET XML ATTRIBUTE BY NAME:C728($vt_fieldRefDomRef; "name"; $vt_name)
					OB SET:C1220($vo_relatedField; "fieldName"; $vt_name)
					
					$vt_tableRefDomRef:=DOM Find XML element:C864($vt_fieldRefDomRef; "table_ref")
					DOM GET XML ATTRIBUTE BY NAME:C728($vt_tableRefDomRef; "uuid"; $vt_uuid)
					OB SET:C1220($vo_relatedField; "tableUuid"; $vt_uuid)
					DOM GET XML ATTRIBUTE BY NAME:C728($vt_tableRefDomRef; "name"; $vt_name)
					OB SET:C1220($vo_relatedField; "tableName"; $vt_name)
					
					Case of 
						: ($vt_kind="source")
							OB SET:C1220($vo_relation; "source"; $vo_relatedField)
							
						: ($vt_kind="destination")
							OB SET:C1220($vo_relation; "destination"; $vo_relatedField)
							
					End case 
					
					CLEAR VARIABLE:C89($vo_relatedField)
				End for 
				
			End if 
			
			ARRAY TEXT:C222($tt_relatedFieldElementDomRef; 0)
			
			If (True:C214)  // relation_extra
				C_TEXT:C284($vt_relationExtraDomRef)
				$vt_relationExtraDomRef:=DOM Find XML element:C864($vt_relationDomRef; "relation_extra")
				If (ok=1)
					For ($attribute_index; 1; DOM Count XML attributes:C727($vt_relationExtraDomRef))
						DOM GET XML ATTRIBUTE BY INDEX:C729($vt_relationExtraDomRef; $attribute_index; $attribute_name; $attribute_value)
						Case of 
							: ($attribute_name="choice_field")
								OB SET:C1220($vo_relation; "choiceField"; Num:C11($attribute_value))
								
							: (($attribute_name="entry_autofill") | ($attribute_name="entry_create") | ($attribute_name="entry_wildchar"))
								OB SET:C1220($vo_relation; UTL_lowerCamelCase($attribute_name); $attribute_value="true")
								
							Else 
								OB SET:C1220($vo_relation; UTL_lowerCamelCase($attribute_name); $attribute_value)
						End case 
					End for 
					
				End if 
				
			End if 
			
			APPEND TO ARRAY:C911($to_relations; $vo_relation)
			CLEAR VARIABLE:C89($vo_relation)
		End for 
		
		
		OB SET ARRAY:C1227($structure_model; "relations"; $to_relations)
		ARRAY OBJECT:C1221($to_relations; 0)
	End if 
	
	ARRAY TEXT:C222($tt_relationElementDomRef; 0)
End if 

If (True:C214)  // index
	ARRAY TEXT:C222($tt_indexElementDomRef; 0)
	$dummy_DOM_ref:=DOM Find XML element:C864($root_DOM_ref; "/base/index"; $tt_indexElementDomRef)
	If (ok=1)
		ARRAY OBJECT:C1221($to_indexes; 0)
		
		C_LONGINT:C283($vl_indexIndex)
		For ($vl_indexIndex; 1; Size of array:C274($tt_indexElementDomRef))
			C_TEXT:C284($vt_indexDomRef)
			$vt_indexDomRef:=$tt_indexElementDomRef{$vl_indexIndex}
			
			C_OBJECT:C1216($vo_index)
			For ($attribute_index; 1; DOM Count XML attributes:C727($vt_indexDomRef))
				DOM GET XML ATTRIBUTE BY INDEX:C729($vt_indexDomRef; $attribute_index; $attribute_name; $attribute_value)
				Case of 
					: ($attribute_name="unique_keys")
						OB SET:C1220($vo_index; "uniqueKeys"; $attribute_value="true")
						
					: ($attribute_name="type")
						OB SET:C1220($vo_index; $attribute_name; Num:C11($attribute_value))
						
					Else 
						OB SET:C1220($vo_index; UTL_lowerCamelCase($attribute_name); $attribute_value)
				End case 
			End for 
			
			If (True:C214)
				ARRAY TEXT:C222($tt_fieldRefElementDomRef; 0)
				$dummy_DOM_ref:=DOM Find XML element:C864($vt_indexDomRef; "field_ref"; $tt_fieldRefElementDomRef)
				If (ok=1)
					ARRAY OBJECT:C1221($to_fieldRef; 0)
					
					C_LONGINT:C283($vl_fieldRefIndex)
					For ($vl_fieldRefIndex; 1; Size of array:C274($tt_fieldRefElementDomRef))
						C_TEXT:C284($vt_fieldRefDomRef)
						$vt_fieldRefDomRef:=$tt_fieldRefElementDomRef{$vl_fieldRefIndex}
						
						C_OBJECT:C1216($vo_fieldRef)
						
						C_TEXT:C284($vt_uuid; $vt_name)
						DOM GET XML ATTRIBUTE BY NAME:C728($vt_fieldRefDomRef; "uuid"; $vt_uuid)
						OB SET:C1220($vo_fieldRef; "fieldUuid"; $vt_uuid)
						DOM GET XML ATTRIBUTE BY NAME:C728($vt_fieldRefDomRef; "name"; $vt_name)
						OB SET:C1220($vo_fieldRef; "fieldName"; $vt_name)
						
						C_TEXT:C284($vt_tableRefDomRef)
						$vt_tableRefDomRef:=DOM Find XML element:C864($vt_fieldRefDomRef; "table_ref")
						DOM GET XML ATTRIBUTE BY NAME:C728($vt_tableRefDomRef; "uuid"; $vt_uuid)
						OB SET:C1220($vo_fieldRef; "tableUuid"; $vt_uuid)
						DOM GET XML ATTRIBUTE BY NAME:C728($vt_tableRefDomRef; "name"; $vt_name)
						OB SET:C1220($vo_fieldRef; "tableName"; $vt_name)
						
						APPEND TO ARRAY:C911($to_fieldRef; $vo_fieldRef)
						CLEAR VARIABLE:C89($vo_fieldRef)
					End for 
					
					OB SET ARRAY:C1227($vo_index; "fieldRef"; $to_fieldRef)
					
					ARRAY OBJECT:C1221($to_fieldRef; 0)
				End if 
				
				ARRAY TEXT:C222($tt_fieldRefElementDomRef; 0)
			End if 
			
			APPEND TO ARRAY:C911($to_indexes; $vo_index)
			CLEAR VARIABLE:C89($vo_index)
			
		End for 
		OB SET ARRAY:C1227($structure_model; "indexes"; $to_indexes)
		ARRAY OBJECT:C1221($to_indexes; 0)
	End if 
	ARRAY TEXT:C222($tt_indexElementDomRef; 0)
End if 

If (True:C214)  // base_extra
	C_TEXT:C284($vt_baseExtraDomRef)
	$vt_baseExtraDomRef:=DOM Find XML element:C864($root_DOM_ref; "/base/base_extra")
	If (ok=1)
		C_OBJECT:C1216($vo_extra)
		
		If (True:C214)  // read the "base_extra" properties
			For ($attribute_index; 1; DOM Count XML attributes:C727($vt_baseExtraDomRef))
				DOM GET XML ATTRIBUTE BY INDEX:C729($vt_baseExtraDomRef; $attribute_index; $attribute_name; $attribute_value)
				Case of 
					: (($attribute_name="resman_stamp") | \
						($attribute_name="resman_marker") | \
						($attribute_name="source_code_stamp") | \
						($attribute_name="intel_code_stamp") | \
						($attribute_name="ppc_code_stamp") | \
						($attribute_name="intel64_code_stamp") | \
						($attribute_name="last_opening_mode") | \
						($attribute_name="v11_open_v12_data_mode") | \
						($attribute_name="open_data_one_version_more_recent_mode"))
						OB SET:C1220($vo_extra; UTL_lowerCamelCase($attribute_name); Num:C11($attribute_value))
						
					: ($attribute_name="__keywordBuildingHash")
						OB SET:C1220($vo_extra; "keywordBuildingHash"; $attribute_value)
						
					: ($attribute_name="__stringCompHash")
						OB SET:C1220($vo_extra; "stringCompHash"; $attribute_value)
						
					: (($attribute_name="is_compiled_database") | \
						($attribute_name="structure_opener") | \
						($attribute_name="source_code_available"))
						OB SET:C1220($vo_extra; UTL_lowerCamelCase($attribute_name); $attribute_value="true")
						
					Else 
						OB SET:C1220($vo_extra; UTL_lowerCamelCase($attribute_name); $attribute_value)
				End case 
			End for 
			
		End if 
		
		If (True:C214)  // read the temp file properties
			C_TEXT:C284($vt_tempFolderDomRef)
			$vt_tempFolderDomRef:=DOM Find XML element:C864($vt_baseExtraDomRef; "temp_folder")
			If (OK=1)
				C_OBJECT:C1216($vo_tempFolder)
				For ($attribute_index; 1; DOM Count XML attributes:C727($vt_tempFolderDomRef))
					DOM GET XML ATTRIBUTE BY INDEX:C729($vt_tempFolderDomRef; $attribute_index; $attribute_name; $attribute_value)
					OB SET:C1220($vo_tempFolder; UTL_lowerCamelCase($attribute_name); $attribute_value)
				End for 
				OB SET:C1220($vo_extra; "tempFolder"; $vo_tempFolder)
				CLEAR VARIABLE:C89($vo_tempFolder)
			End if 
		End if 
		
		If (True:C214)  // read the journal file properties
			C_TEXT:C284($vt_journalFileDomRef)
			var $vo_journal : Object
			$vo_journal:=Null:C1517
			$vt_journalFileDomRef:=DOM Find XML element:C864($vt_baseExtraDomRef; "journal_file")
			If (OK=1)
				For ($attribute_index; 1; DOM Count XML attributes:C727($vt_journalFileDomRef))
					DOM GET XML ATTRIBUTE BY INDEX:C729($vt_journalFileDomRef; $attribute_index; $attribute_name; $attribute_value)
					Case of 
						: ($attribute_name="sequence_number")
							OB SET:C1220($vo_journal; "sequenceNumber"; Num:C11($attribute_value))
							
						: ($attribute_name="journal_file_enabled")
							OB SET:C1220($vo_journal; "journalFileEnabled"; $attribute_value="true")
							
						Else 
							OB SET:C1220($vo_journal; UTL_lowerCamelCase($attribute_name); $attribute_value)
							
					End case 
				End for 
			End if 
			
			OB SET:C1220($vo_extra; "journal"; $vo_journal)
			CLEAR VARIABLE:C89($vo_journal)
		End if 
		
		OB SET:C1220($structure_model; "extra"; $vo_extra)
		CLEAR VARIABLE:C89($vo_extra)
	End if 
End if 

DOM CLOSE XML:C722($root_DOM_ref)
