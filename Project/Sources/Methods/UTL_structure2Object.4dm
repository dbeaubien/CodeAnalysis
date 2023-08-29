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
//  C_TEXT($vt_xml)
//  EXPORT STRUCTURE($vt_xml)
//
//  C_OBJECT($vo_structure)
//  $vo_structure:=UTL_structure2Object($vt_xml)
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

C_OBJECT:C1216($0; $vo_report)
C_TEXT:C284($1; $vt_xml)

ASSERT:C1129(Count parameters:C259>0; "requires 1 parameter")

$vt_xml:=$1

C_BOOLEAN:C305($vb_useXpathNewSyntax)
$vb_useXpathNewSyntax:=XML__XPathNewSyntax

C_TEXT:C284($vt_rootDomRef)
$vt_rootDomRef:=DOM Parse XML variable:C720($vt_xml)
If (ok=1)
	$vo_report:=New object:C1471
	
	C_TEXT:C284($vt_attrName; $vt_attrValue)
	
	If (True:C214)  // schema
		C_TEXT:C284($vt_xpath)
		
		// new xml syntax : xpath absolu OK
		$vt_xpath:="/base/schema"
		
		ARRAY TEXT:C222($tt_schemaElementDomRef; 0)
		
		C_TEXT:C284($vt_dummyDomRef)
		$vt_dummyDomRef:=DOM Find XML element:C864($vt_rootDomRef; $vt_xpath; $tt_schemaElementDomRef)
		If (ok=1)
			ARRAY OBJECT:C1221($to_schema; 0)
			C_LONGINT:C283($vl_schemaIndex)
			For ($vl_schemaIndex; 1; Size of array:C274($tt_schemaElementDomRef))
				
				C_TEXT:C284($vt_schemaElementDomRef)
				$vt_schemaElementDomRef:=$tt_schemaElementDomRef{$vl_schemaIndex}
				C_OBJECT:C1216($vo_schema)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($vt_schemaElementDomRef; "name"; $vt_attrValue)
				OB SET:C1220($vo_schema; "name"; $vt_attrValue)
				
				APPEND TO ARRAY:C911($to_schema; $vo_schema)
				CLEAR VARIABLE:C89($vo_schema)
			End for 
			OB SET ARRAY:C1227($vo_report; "schemas"; $to_schema)
			ARRAY OBJECT:C1221($to_schema; 0)
		End if 
		ARRAY TEXT:C222($tt_schemaElementDomRef; 0)
		
	End if 
	
	If (True:C214)  // table
		C_TEXT:C284($vt_xpath)
		
		// new xml syntax : xpath absolu OK
		$vt_xpath:="/base/table"
		
		ARRAY TEXT:C222($tt_tableElementDomRef; 0)
		
		C_TEXT:C284($vt_dummyDomRef)
		$vt_dummyDomRef:=DOM Find XML element:C864($vt_rootDomRef; $vt_xpath; $tt_tableElementDomRef)
		If (ok=1)
			C_LONGINT:C283($vl_nbTable)
			$vl_nbTable:=Size of array:C274($tt_tableElementDomRef)
			ARRAY LONGINT:C221($tl_tableNo; $vl_nbTable)
			ARRAY TEXT:C222($tt_tableName; $vl_nbTable)
			
			
			ARRAY OBJECT:C1221($to_tables; 0)
			
			C_LONGINT:C283($vl_tableIndex)
			For ($vl_tableIndex; 1; $vl_nbTable)
				C_TEXT:C284($vt_tableElementDomRef)
				$vt_tableElementDomRef:=$tt_tableElementDomRef{$vl_tableIndex}
				
				C_OBJECT:C1216($vo_table)
				
				C_TEXT:C284($vt_attrName; $vt_attrValue)
				C_LONGINT:C283($vl_attrIndex)
				
				If (True:C214)  // read the table properties
					For ($vl_attrIndex; 1; DOM Count XML attributes:C727($vt_tableElementDomRef))
						DOM GET XML ATTRIBUTE BY INDEX:C729($vt_tableElementDomRef; $vl_attrIndex; $vt_attrName; $vt_attrValue)
						Case of 
							: ($vt_attrName="id")
								OB SET:C1220($vo_table; $vt_attrName; Num:C11($vt_attrValue))
								
							: ($vt_attrName="sql_schema_id")
								OB SET:C1220($vo_table; "sqlSchemaId"; Num:C11($vt_attrValue))
								
							: ($vt_attrName="sql_schema_name")
								OB SET:C1220($vo_table; "sqlSchemaName"; $vt_attrValue)
								
							: (($vt_attrName="uuid") | ($vt_attrName="name"))
								OB SET:C1220($vo_table; $vt_attrName; $vt_attrValue)
								
							: (($vt_attrValue="true") | ($vt_attrValue="false"))  // "prevent_journaling", "leave_tag_on_delete"
								OB SET:C1220($vo_table; UTL_lowerCamelCase($vt_attrName); $vt_attrValue="true")
								
							Else 
								OB SET:C1220($vo_table; UTL_lowerCamelCase($vt_attrName); $vt_attrValue)
						End case 
					End for 
				End if 
				
				If (True:C214)  // read the trigger properties table/table_extra
					C_OBJECT:C1216($vo_triggers)
					
					// new xml syntax
					If ($vb_useXpathNewSyntax)
						$vt_xpath:="table_extra"
					Else 
						$vt_xpath:="table/table_extra"
					End if 
					
					C_TEXT:C284($vt_tableExtraDomRef)
					$vt_tableExtraDomRef:=DOM Find XML element:C864($vt_tableElementDomRef; $vt_xpath)
					
					If (True:C214)  // Read the comment of the table
						
						// new xml syntax
						If ($vb_useXpathNewSyntax)
							$vt_xpath:="comment"
						Else 
							$vt_xpath:="table_extra/comment"
						End if 
						ARRAY TEXT:C222($tt_commentElementDomRef; 0)
						$vt_dummyDomRef:=DOM Find XML element:C864($vt_tableExtraDomRef; $vt_xpath; $tt_commentElementDomRef)
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
						
					End if 
					
					
					C_TEXT:C284($vt_attrName; $vt_attrValue)
					C_LONGINT:C283($vl_attrIndex)
					For ($vl_attrIndex; 1; DOM Count XML attributes:C727($vt_tableExtraDomRef))
						DOM GET XML ATTRIBUTE BY INDEX:C729($vt_tableExtraDomRef; $vl_attrIndex; $vt_attrName; $vt_attrValue)
						Case of 
							: (($vt_attrName="visible") | ($vt_attrName="trashed"))
								OB SET:C1220($vo_table; $vt_attrName; $vt_attrValue="true")
								
							: ($vt_attrName="trigger_load")
								OB SET:C1220($vo_triggers; "onLoad"; $vt_attrValue="true")
								
							: ($vt_attrName="trigger_insert")
								OB SET:C1220($vo_triggers; "onInsert"; $vt_attrValue="true")
								
							: ($vt_attrName="trigger_update")
								OB SET:C1220($vo_triggers; "onUpdate"; $vt_attrValue="true")
								
							: ($vt_attrName="trigger_delete")
								OB SET:C1220($vo_triggers; "onDelete"; $vt_attrValue="true")
								
						End case 
					End for 
					
					OB SET:C1220($vo_table; "triggers"; $vo_triggers)
					CLEAR VARIABLE:C89($vo_triggers)
				End if 
				
				If (True:C214)  // primary_key
					
					// new xml syntax
					If ($vb_useXpathNewSyntax)
						$vt_xpath:="primary_key"
					Else 
						$vt_xpath:="table/primary_key"
					End if 
					
					ARRAY TEXT:C222($tt_primaryKeyElementDomRef; 0)
					
					$vt_dummyDomRef:=DOM Find XML element:C864($vt_tableElementDomRef; $vt_xpath; $tt_primaryKeyElementDomRef)
					If (ok=1)
						
						C_LONGINT:C283($vl_nbPrimaryKey)
						$vl_nbPrimaryKey:=Size of array:C274($tt_primaryKeyElementDomRef)
						
						ARRAY OBJECT:C1221($to_primaryKeys; 0)
						
						C_LONGINT:C283($vl_primaryKeyIndex)
						For ($vl_primaryKeyIndex; 1; $vl_nbPrimaryKey)
							C_TEXT:C284($vt_primaryKeyDomRef)
							$vt_primaryKeyDomRef:=$tt_primaryKeyElementDomRef{$vl_primaryKeyIndex}
							
							C_OBJECT:C1216($vo_primaryKey)
							
							For ($vl_attrIndex; 1; DOM Count XML attributes:C727($vt_primaryKeyDomRef))
								DOM GET XML ATTRIBUTE BY INDEX:C729($vt_primaryKeyDomRef; $vl_attrIndex; $vt_attrName; $vt_attrValue)
								OB SET:C1220($vo_primaryKey; UTL_lowerCamelCase($vt_attrName); $vt_attrValue)
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
					
					// new xml syntax
					If ($vb_useXpathNewSyntax)
						$vt_xpath:="field"
					Else 
						$vt_xpath:="table/field"
					End if 
					
					ARRAY TEXT:C222($tt_fieldElementDomRef; 0)
					
					$vt_dummyDomRef:=DOM Find XML element:C864($vt_tableElementDomRef; $vt_xpath; $tt_fieldElementDomRef)
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
								For ($vl_attrIndex; 1; DOM Count XML attributes:C727($vt_fieldElementDomRef))
									DOM GET XML ATTRIBUTE BY INDEX:C729($vt_fieldElementDomRef; $vl_attrIndex; $vt_attrName; $vt_attrValue)
									Case of 
										: ($vt_attrName="id")
											OB SET:C1220($vo_field; $vt_attrName; Num:C11($vt_attrValue))
											
										: (($vt_attrName="uuid") | ($vt_attrName="name"))
											OB SET:C1220($vo_field; $vt_attrName; $vt_attrValue)
											
										: ($vt_attrName="type")
											OB SET:C1220($vo_field; $vt_attrName; Num:C11($vt_attrValue))
											C_TEXT:C284($vt_typeStr)
											$vt_typeStr:=""
											C_LONGINT:C283($vl_type)
											$vl_type:=Num:C11($vt_attrValue)
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
													$vt_typeStr:="unknown ("+$vt_attrValue+")"
													
											End case 
											
											OB SET:C1220($vo_field; "typeStr"; $vt_typeStr)
											
										: ($vt_attrName="text_switch_size") | ($vt_attrName="blob_switch_size")
											OB SET:C1220($vo_field; UTL_lowerCamelCase($vt_attrName); Num:C11($vt_attrValue))
											
										: (($vt_attrValue="true") | ($vt_attrValue="false"))  // "prevent_journaling", "leave_tag_on_delete"
											OB SET:C1220($vo_field; UTL_lowerCamelCase($vt_attrName); $vt_attrValue="true")
											
										Else 
											OB SET:C1220($vo_field; UTL_lowerCamelCase($vt_attrName); $vt_attrValue)
									End case 
								End for 
							End if 
							
							// index_ref
							
							If (True:C214)  // read the field index properties
								
								// new xml syntax
								If ($vb_useXpathNewSyntax)
									$vt_xpath:="index_ref[1]"
								Else 
									$vt_xpath:="field/index_ref[1]"
								End if 
								C_TEXT:C284($vt_indexDomRef)
								$vt_indexDomRef:=DOM Find XML element:C864($vt_fieldElementDomRef; $vt_xpath)
								If (ok=1)
									C_TEXT:C284($vt_uuid)
									DOM GET XML ATTRIBUTE BY NAME:C728($vt_indexDomRef; "uuid"; $vt_uuid)
									OB SET:C1220($vo_field; "indexUuid"; $vt_uuid)
								End if 
							End if 
							
							If (True:C214)  // read the field extra properties
								
								// new xml syntax
								If ($vb_useXpathNewSyntax)
									$vt_xpath:="field_extra[1]/comment"
								Else 
									$vt_xpath:="field/field_extra[1]/comment"
								End if 
								
								ARRAY TEXT:C222($tt_commentElementDomRef; 0)
								$vt_dummyDomRef:=DOM Find XML element:C864($vt_fieldElementDomRef; $vt_xpath; $tt_commentElementDomRef)
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
								
								// new xml syntax
								If ($vb_useXpathNewSyntax)
									$vt_xpath:="field_extra[1]/tip[1]"
								Else 
									$vt_xpath:="field/field_extra[1]/tip[1]"
								End if 
								
								C_TEXT:C284($vt_tipElementDomRef)
								$vt_tipElementDomRef:=DOM Find XML element:C864($vt_fieldElementDomRef; $vt_xpath; $tt_commentElementDomRef)
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
									
									// new xml syntax
									If ($vb_useXpathNewSyntax)
										$vt_xpath:="field_extra[1]"
									Else 
										$vt_xpath:="field/field_extra[1]"
									End if 
									
									C_TEXT:C284($vt_extraDomRef)
									$vt_extraDomRef:=DOM Find XML element:C864($vt_fieldElementDomRef; $vt_xpath; $tt_commentElementDomRef)
									If (ok=1)  // read the field extra attributes
										For ($vl_attrIndex; 1; DOM Count XML attributes:C727($vt_extraDomRef))
											DOM GET XML ATTRIBUTE BY INDEX:C729($vt_extraDomRef; $vl_attrIndex; $vt_attrName; $vt_attrValue)
											Case of 
												: ($vt_attrName="position")
													OB SET:C1220($vo_field; $vt_attrName; Num:C11($vt_attrValue))
													
												: ($vt_attrName="enumeration_id")
													OB SET:C1220($vo_field; "enumerationId"; Num:C11($vt_attrValue))
													
												: (($vt_attrValue="true") | ($vt_attrValue="false"))  // "prevent_journaling", "leave_tag_on_delete"
													OB SET:C1220($vo_field; UTL_lowerCamelCase($vt_attrName); $vt_attrValue="true")
													
												Else 
													OB SET:C1220($vo_field; UTL_lowerCamelCase($vt_attrName); $vt_attrValue)
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
				
				APPEND TO ARRAY:C911($to_tables; $vo_table)
				CLEAR VARIABLE:C89($vo_table)
			End for 
			
			OB SET ARRAY:C1227($vo_report; "tables"; $to_tables)
			ARRAY OBJECT:C1221($to_tables; 0)
		End if 
		
		
		ARRAY TEXT:C222($tt_tableElementDomRef; 0)
	End if 
	
	If (True:C214)  // relation
		
		// new xml syntax : xpath absolu OK
		$vt_xpath:="/base/relation"
		
		ARRAY TEXT:C222($tt_relationElementDomRef; 0)
		
		
		C_TEXT:C284($vt_dummyDomRef)
		$vt_dummyDomRef:=DOM Find XML element:C864($vt_rootDomRef; $vt_xpath; $tt_relationElementDomRef)
		If (ok=1)
			ARRAY OBJECT:C1221($to_relations; 0)
			
			C_LONGINT:C283($vl_relationIndex)
			For ($vl_relationIndex; 1; Size of array:C274($tt_relationElementDomRef))
				C_TEXT:C284($vt_relationDomRef)
				$vt_relationDomRef:=$tt_relationElementDomRef{$vl_relationIndex}
				
				C_OBJECT:C1216($vo_relation)
				
				C_LONGINT:C283($vl_attrIndex)
				For ($vl_attrIndex; 1; DOM Count XML attributes:C727($vt_relationDomRef))
					DOM GET XML ATTRIBUTE BY INDEX:C729($vt_relationDomRef; $vl_attrIndex; $vt_attrName; $vt_attrValue)
					Case of 
						: ($vt_attrName="uuid")
							OB SET:C1220($vo_relation; $vt_attrName; $vt_attrValue)
							
						: ($vt_attrName="integrity")  // (none | reject | delete)"none"
							OB SET:C1220($vo_relation; $vt_attrName; $vt_attrValue)
							
						: ($vt_attrName="state")
							OB SET:C1220($vo_relation; $vt_attrName; Num:C11($vt_attrValue))
							
						: (($vt_attrName="auto_load_Nto1") | ($vt_attrName="auto_load_1toN") | ($vt_attrName="foreign_key"))
							OB SET:C1220($vo_relation; UTL_lowerCamelCase($vt_attrName); $vt_attrValue="true")
							
						: ($vt_attrName="name_Nto1")
							OB SET:C1220($vo_relation; $vt_attrName; $vt_attrValue)
							
						: ($vt_attrName="name_1toN")
							OB SET:C1220($vo_relation; $vt_attrName; $vt_attrValue)
							
						Else 
							OB SET:C1220($vo_relation; UTL_lowerCamelCase($vt_attrName); $vt_attrValue)
					End case 
				End for 
				
				//C_TEXTE($vt_xpath)
				
				// new xml syntax
				If ($vb_useXpathNewSyntax)
					$vt_xpath:="related_field"
				Else 
					$vt_xpath:="relation/related_field"
				End if 
				
				
				ARRAY TEXT:C222($tt_relatedFieldElementDomRef; 0)
				
				C_TEXT:C284($vt_dummyDomRef)
				$vt_dummyDomRef:=DOM Find XML element:C864($vt_relationDomRef; $vt_xpath; $tt_relatedFieldElementDomRef)
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
						
						// new xml syntax
						If ($vb_useXpathNewSyntax)
							$vt_xpath:="field_ref"
						Else 
							$vt_xpath:="related_field/field_ref"
						End if 
						
						$vt_fieldRefDomRef:=DOM Find XML element:C864($vt_relatedFieldDomRef; $vt_xpath)
						DOM GET XML ATTRIBUTE BY NAME:C728($vt_fieldRefDomRef; "uuid"; $vt_uuid)
						OB SET:C1220($vo_relatedField; "fieldUuid"; $vt_uuid)
						DOM GET XML ATTRIBUTE BY NAME:C728($vt_fieldRefDomRef; "name"; $vt_name)
						OB SET:C1220($vo_relatedField; "fieldName"; $vt_name)
						
						// new xml syntax
						If ($vb_useXpathNewSyntax)
							$vt_xpath:="table_ref"
						Else 
							$vt_xpath:="field_ref/table_ref"
						End if 
						
						$vt_tableRefDomRef:=DOM Find XML element:C864($vt_fieldRefDomRef; $vt_xpath)
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
					
					// new xml syntax
					If ($vb_useXpathNewSyntax)
						$vt_xpath:="relation_extra"
					Else 
						$vt_xpath:="relation/relation_extra"
					End if 
					
					C_TEXT:C284($vt_relationExtraDomRef)
					$vt_relationExtraDomRef:=DOM Find XML element:C864($vt_relationDomRef; $vt_xpath)
					If (ok=1)
						
						C_LONGINT:C283($vl_attrIndex)
						For ($vl_attrIndex; 1; DOM Count XML attributes:C727($vt_relationExtraDomRef))
							DOM GET XML ATTRIBUTE BY INDEX:C729($vt_relationExtraDomRef; $vl_attrIndex; $vt_attrName; $vt_attrValue)
							Case of 
								: ($vt_attrName="choice_field")
									OB SET:C1220($vo_relation; "choiceField"; Num:C11($vt_attrValue))
									
								: (($vt_attrName="entry_autofill") | ($vt_attrName="entry_create") | ($vt_attrName="entry_wildchar"))
									OB SET:C1220($vo_relation; UTL_lowerCamelCase($vt_attrName); $vt_attrValue="true")
									
								Else 
									OB SET:C1220($vo_relation; UTL_lowerCamelCase($vt_attrName); $vt_attrValue)
							End case 
						End for 
						
					End if 
					
				End if 
				
				APPEND TO ARRAY:C911($to_relations; $vo_relation)
				CLEAR VARIABLE:C89($vo_relation)
			End for 
			
			
			OB SET ARRAY:C1227($vo_report; "relations"; $to_relations)
			ARRAY OBJECT:C1221($to_relations; 0)
		End if 
		
		ARRAY TEXT:C222($tt_relationElementDomRef; 0)
	End if 
	
	If (True:C214)  // index
		
		// new xml syntax : xpath absolu OK
		$vt_xpath:="/base/index"
		
		ARRAY TEXT:C222($tt_indexElementDomRef; 0)
		
		C_TEXT:C284($vt_dummyDomRef)
		$vt_dummyDomRef:=DOM Find XML element:C864($vt_rootDomRef; $vt_xpath; $tt_indexElementDomRef)
		If (ok=1)
			ARRAY OBJECT:C1221($to_indexes; 0)
			
			C_LONGINT:C283($vl_indexIndex)
			For ($vl_indexIndex; 1; Size of array:C274($tt_indexElementDomRef))
				C_TEXT:C284($vt_indexDomRef)
				$vt_indexDomRef:=$tt_indexElementDomRef{$vl_indexIndex}
				
				C_OBJECT:C1216($vo_index)
				
				C_LONGINT:C283($vl_attrIndex)
				For ($vl_attrIndex; 1; DOM Count XML attributes:C727($vt_indexDomRef))
					DOM GET XML ATTRIBUTE BY INDEX:C729($vt_indexDomRef; $vl_attrIndex; $vt_attrName; $vt_attrValue)
					Case of 
						: ($vt_attrName="unique_keys")
							OB SET:C1220($vo_index; "uniqueKeys"; $vt_attrValue="true")
							
						: ($vt_attrName="type")
							OB SET:C1220($vo_index; $vt_attrName; Num:C11($vt_attrValue))
							
						Else 
							OB SET:C1220($vo_index; UTL_lowerCamelCase($vt_attrName); $vt_attrValue)
					End case 
				End for 
				
				If (True:C214)
					ARRAY TEXT:C222($tt_fieldRefElementDomRef; 0)
					
					// new xml syntax
					If ($vb_useXpathNewSyntax)
						$vt_xpath:="field_ref"
					Else 
						$vt_xpath:="index/field_ref"
					End if 
					
					C_TEXT:C284($vt_dummyDomRef)
					$vt_dummyDomRef:=DOM Find XML element:C864($vt_indexDomRef; $vt_xpath; $tt_fieldRefElementDomRef)
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
							
							// new xml syntax
							If ($vb_useXpathNewSyntax)
								$vt_xpath:="table_ref"
							Else 
								$vt_xpath:="field_ref/table_ref"
							End if 
							
							C_TEXT:C284($vt_tableRefDomRef)
							$vt_tableRefDomRef:=DOM Find XML element:C864($vt_fieldRefDomRef; $vt_xpath)
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
			OB SET ARRAY:C1227($vo_report; "indexes"; $to_indexes)
			ARRAY OBJECT:C1221($to_indexes; 0)
		End if 
		ARRAY TEXT:C222($tt_indexElementDomRef; 0)
	End if 
	
	If (True:C214)  // base_extra
		
		// new xml syntax : xpath absolu OK
		$vt_xpath:="/base/base_extra"
		
		C_TEXT:C284($vt_baseExtraDomRef)
		$vt_baseExtraDomRef:=DOM Find XML element:C864($vt_rootDomRef; $vt_xpath)
		If (ok=1)
			C_OBJECT:C1216($vo_extra)
			
			If (True:C214)  // read the "base_extra" properties
				For ($vl_attrIndex; 1; DOM Count XML attributes:C727($vt_baseExtraDomRef))
					DOM GET XML ATTRIBUTE BY INDEX:C729($vt_baseExtraDomRef; $vl_attrIndex; $vt_attrName; $vt_attrValue)
					Case of 
						: (($vt_attrName="resman_stamp") | \
							($vt_attrName="resman_marker") | \
							($vt_attrName="source_code_stamp") | \
							($vt_attrName="intel_code_stamp") | \
							($vt_attrName="ppc_code_stamp") | \
							($vt_attrName="intel64_code_stamp") | \
							($vt_attrName="last_opening_mode") | \
							($vt_attrName="v11_open_v12_data_mode") | \
							($vt_attrName="open_data_one_version_more_recent_mode"))
							OB SET:C1220($vo_extra; UTL_lowerCamelCase($vt_attrName); Num:C11($vt_attrValue))
							
						: ($vt_attrName="__keywordBuildingHash")
							OB SET:C1220($vo_extra; "keywordBuildingHash"; $vt_attrValue)
							
						: ($vt_attrName="__stringCompHash")
							OB SET:C1220($vo_extra; "stringCompHash"; $vt_attrValue)
							
						: (($vt_attrName="is_compiled_database") | \
							($vt_attrName="structure_opener") | \
							($vt_attrName="source_code_available"))
							OB SET:C1220($vo_extra; UTL_lowerCamelCase($vt_attrName); $vt_attrValue="true")
							
						Else 
							OB SET:C1220($vo_extra; UTL_lowerCamelCase($vt_attrName); $vt_attrValue)
					End case 
				End for 
				
			End if 
			
			If (True:C214)  // read the temp file properties
				
				// new xml syntax
				If ($vb_useXpathNewSyntax)
					$vt_xpath:="temp_folder"
				Else 
					$vt_xpath:="base_extra/temp_folder"
				End if 
				
				C_TEXT:C284($vt_tempFolderDomRef)
				$vt_tempFolderDomRef:=DOM Find XML element:C864($vt_baseExtraDomRef; $vt_xpath)
				If (OK=1)
					C_OBJECT:C1216($vo_tempFolder)
					For ($vl_attrIndex; 1; DOM Count XML attributes:C727($vt_tempFolderDomRef))
						DOM GET XML ATTRIBUTE BY INDEX:C729($vt_tempFolderDomRef; $vl_attrIndex; $vt_attrName; $vt_attrValue)
						OB SET:C1220($vo_tempFolder; UTL_lowerCamelCase($vt_attrName); $vt_attrValue)
					End for 
					OB SET:C1220($vo_extra; "tempFolder"; $vo_tempFolder)
					CLEAR VARIABLE:C89($vo_tempFolder)
				End if 
			End if 
			
			If (True:C214)  // read the journal file properties
				
				// new xml syntax
				If ($vb_useXpathNewSyntax)
					$vt_xpath:="journal_file"
				Else 
					$vt_xpath:="base_extra/journal_file"
				End if 
				
				C_TEXT:C284($vt_journalFileDomRef)
				$vt_journalFileDomRef:=DOM Find XML element:C864($vt_baseExtraDomRef; $vt_xpath)
				C_OBJECT:C1216($vo_journal)
				For ($vl_attrIndex; 1; DOM Count XML attributes:C727($vt_journalFileDomRef))
					DOM GET XML ATTRIBUTE BY INDEX:C729($vt_journalFileDomRef; $vl_attrIndex; $vt_attrName; $vt_attrValue)
					Case of 
						: ($vt_attrName="sequence_number")
							OB SET:C1220($vo_journal; "sequenceNumber"; Num:C11($vt_attrValue))
							
						: ($vt_attrName="journal_file_enabled")
							OB SET:C1220($vo_journal; "journalFileEnabled"; $vt_attrValue="true")
							
						Else 
							OB SET:C1220($vo_journal; UTL_lowerCamelCase($vt_attrName); $vt_attrValue)
							
					End case 
				End for 
				
				OB SET:C1220($vo_extra; "journal"; $vo_journal)
				CLEAR VARIABLE:C89($vo_journal)
			End if 
			
			OB SET:C1220($vo_report; "extra"; $vo_extra)
			CLEAR VARIABLE:C89($vo_extra)
		End if 
	End if 
	
	DOM CLOSE XML:C722($vt_rootDomRef)
End if 

$0:=$vo_report