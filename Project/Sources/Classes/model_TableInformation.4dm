/* 
A model that contains information on the tables and fields.
*/

Class constructor
	This:C1470._init()
	
	
/************ PUBLIC FUNCTIONS ************************/
Function Refresh()
	This:C1470._log("starting "+Uppercase:C13(Current method name:C684))
	This:C1470._init()
	This:C1470._log("  after init()")
	This:C1470._load_catalog_info()
	This:C1470._log("  after _load_catalog_info()")
	This:C1470._load_table_model()
	This:C1470._log("  after _load_table_model()")
	
	var $ms : Integer
	$ms:=Milliseconds:C459
	This:C1470._load_field_model()
	This:C1470._log("  after _load_field_model()")
	
	//Log_INFO("*** cs.model_TableInformation._load_field_model() took "+String(Milliseconds-$ms; "###,###,###,##0")+"ms")
	This:C1470._log("  cs.model_TableInformation._load_field_model() took "+String:C10(Milliseconds:C459-$ms; "###,###,###,##0")+"ms")
	This:C1470._log("completed "+Uppercase:C13(Current method name:C684))
	
	
Function GetTableFilteredList($name : Text)->$table_list : Collection
	This:C1470._log("starting "+Uppercase:C13(Current method name:C684))
	If ($name="")
		$table_list:=This:C1470._table_model.copy()
	Else 
		$table_list:=This:C1470._table_model.query("table=:1"; $name+"@").copy()
	End if 
	This:C1470._log("completed "+Uppercase:C13(Current method name:C684))
	
	
Function GetFieldFilteredList($name : Text)->$field_list : Collection
	This:C1470._log("starting "+Uppercase:C13(Current method name:C684))
	If ($name="")
		$field_list:=This:C1470._field_model.copy()
	Else 
		$field_list:=This:C1470._field_model.query("table=:1 OR field=:1"; $name+"@").copy()
	End if 
	This:C1470._log("completed "+Uppercase:C13(Current method name:C684))
	
	
Function GetNotMappedToBlankValues()->$field_list : Collection
	This:C1470._log("starting "+Uppercase:C13(Current method name:C684))
	$field_list:=This:C1470._field_model.query("isMappedToBlankValues=:1"; False:C215).copy()
	This:C1470._log("completed "+Uppercase:C13(Current method name:C684))
	
	
/************ PRIVATE FUNCTIONS ************************/
Function _init()
	This:C1470._table_model:=New collection:C1472
	This:C1470._field_model:=New collection:C1472
	This:C1470._structure_catalog_full_model:={}
	This:C1470._structure_catalog_model:=New collection:C1472
	This:C1470._structure_catalog_tables_by_no:={}
	
	
Function _load_catalog_info()
	var $structure_xml : Text
	If (Folder:C1567("/PROJECT").folder("Sources").file("catalog.4DCatalog").exists)
		$structure_xml:=Folder:C1567("/PROJECT").folder("Sources").file("catalog.4DCatalog").getText()
	Else 
		EXPORT STRUCTURE:C1311($structure_xml)
	End if 
	
	This:C1470._structure_catalog_full_model:=UTL_structure2Object($structure_xml)
	This:C1470._structure_catalog_model:=This:C1470._structure_catalog_full_model.tables
	This:C1470._structure_catalog_tables_by_no:=This:C1470._structure_catalog_full_model.tables_by_no
	
	
Function _load_table_model()
	var $table : Object
	var $table_no : Integer
	For ($table_no; 1; Get last table number:C254)  // use classic since only tables with PKs are known to orda
		If (Is table number valid:C999($table_no))
			$table:=This:C1470._structure_catalog_tables_by_no[String:C10($table_no)]
			This:C1470._table_model.push(This:C1470._get_detail_for_table($table; $table_no))
		End if 
	End for 
	This:C1470._table_model:=This:C1470._table_model.orderBy("table asc")
	
	
Function _load_field_model()
	var $table : Object
	var $table_model : Object
	var $table_no; $field_no : Integer
	For ($table_no; 1; Get last table number:C254)  // use classic since only tables with PKs are known to orda
		If (Is table number valid:C999($table_no))
			$table:=This:C1470._structure_catalog_tables_by_no[String:C10($table_no)]
			$table_model:=This:C1470._table_model.query("tableNumber=:1"; $table_no)[0]
			
			For ($field_no; 1; Get last field number:C255($table_no))  // use classic since only tables with PKs are known to orda
				If (Is field number valid:C1000($table_no; $field_no))
					This:C1470._field_model.push(This:C1470._get_detail_for_field($table_model; $table; $table_no; $field_no))
				End if 
			End for 
		End if 
	End for 
	This:C1470._field_model:=This:C1470._field_model.orderBy("table asc, field asc")
	
	
Function _get_detail_for_field($table_model : Object; $table : Object; $table_no : Integer; $field_no : Integer)->$field_detail : Object
	If ($table=Null:C1517) || ($table_model=Null:C1517)
		return 
	End if 
	
	var $field_attributes : Object
	var $type; $length : Integer
	var $isIndexed; $isUnique; $isInvisible : Boolean
	GET FIELD PROPERTIES:C258($table_no; $field_no; $type; $length; $isIndexed; $isUnique; $isInvisible)
	
	var $field : Object
	$field:=$table.fields.query("id=:1"; $field_no).at(0)
	
	$field_attributes:=This:C1470._get_field_attributes_via_sql($field)
	
	$field_detail:=New object:C1471
	$field_detail.field:=Field name:C257($table_no; $field_no)
	$field_detail.name:="["+$table_model.table+"]"+$field_detail.field
	$field_detail.table:=$table_model.table
	$field_detail.tableNumber:=$table_no
	$field_detail.fieldNumber:=$field_no
	If ($table_model.primaryKey_field_name#"")  // can use orda
		$field_detail.isPrimaryKey:=($table_model.primaryKey_field_name=$field_detail.field)
	Else 
		$field_detail.isPrimaryKey:=False:C215
	End if 
	$field_detail.isIndexed:=$isIndexed
	$field_detail.isUnique:=$isIndexed
	$field_detail.isInvisible:=$isInvisible
	$field_detail.type:=This:C1470._field_type_to_text($type; $length)
	$field_detail.exposed_to_REST:=$field_attributes.is_REST
	$field_detail.isAutoIncrement:=$field_attributes.is_AutoIncrement
	$field_detail.isAutoGenerate:=$field_attributes.is_AutoGenerate
	$field_detail.isNullable:=$field_attributes.is_Nullable
	$field_detail.isNeverNullable:=($field=Null:C1517) ? False:C215 : (String:C10($field.neverNull)="true")
	$field_detail.isMappedToBlankValues:=($field=Null:C1517) ? False:C215 : (String:C10($field.neverNull)="true")
	If ($field_detail.isIndexed)
		$field_detail.indexType:=This:C1470._structure_IndexType2Name(Structure_GetFieldIndexType($table_no; $field_no))
	Else 
		$field_detail.indexType:="-"
	End if 
	$field_detail.notes:=""
	
	
Function _get_detail_for_table($table : Object; $table_no : Integer)->$table_details : Object
	If ($table=Null:C1517)
		return 
	End if 
	var $isInvisible; $trigger_SaveNew; $trigger_SaveRec; $trigger_DelRec : Boolean
	GET TABLE PROPERTIES:C687($table_no; $isInvisible; $trigger_SaveNew; $trigger_SaveRec; $trigger_DelRec)
	$table_details:=New object:C1471
	$table_details.table:=Table name:C256($table_no)
	$table_details.tableNumber:=$table_no
	$table_details.is_logged:=Not:C34(Bool:C1537($table.preventJournaling)=True:C214)
	$table_details.is_invisible:=$isInvisible
	$table_details.triggers:=New object:C1471
	$table_details.triggers.on_saving_new:=$trigger_SaveNew
	$table_details.triggers.on_saving_existing:=$trigger_SaveRec
	$table_details.triggers.on_deleting:=$trigger_DelRec
	$table_details.exposed_to_REST:=Not:C34(Bool:C1537($table.hideInRest)=True:C214)
	If (ds:C1482[$table_details.table]#Null:C1517)  // orda only knows about tables with PKs
		$table_details.primaryKey_field_name:=String:C10(ds:C1482[$table_details.table].getInfo().primaryKey)
	Else 
		$table_details.primaryKey_field_name:=""
	End if 
	$table_details.num_records:=Records in table:C83(Table:C252($table_no)->)
	If ($table_details.num_records>0)
		$table_details.num_deleted:=This:C1470._get_table_deleted_count($table_no)
	Else 
		$table_details.num_deleted:=0
	End if 
	
	
Function _get_table_deleted_count($table_no : Integer)->$num_deleted : Integer
	READ ONLY:C145(*)
	ALL RECORDS:C47(Table:C252($table_no)->)
	CREATE SET:C116(Table:C252($table_no)->; "model_tableInfoSet")
	ARRAY BOOLEAN:C223($setArr; 0)
	BOOLEAN ARRAY FROM SET:C646($setArr; "model_tableInfoSet")
	CLEAR SET:C117("model_tableInfoSet")
	$num_deleted:=Size of array:C274($setArr)-Records in table:C83(Table:C252($table_no)->)+1
	ARRAY BOOLEAN:C223($setArr; 0)
	
	
Function _field_type_to_text($type : Integer; $length : Integer)->$type_as_text : Text
	Case of 
		: ($type=Is text:K8:3)
			$type_as_text:="Text"
			
		: ($type=Is alpha field:K8:1) & ($length>0)
			$type_as_text:="A"+String:C10($length)
			
		: ($type=Is alpha field:K8:1)
			$type_as_text:="UUID"
			
		: ($type=Is boolean:K8:9)
			$type_as_text:="Bool"
			
		: ($type=Is time:K8:8)
			$type_as_text:="Time"
			
		: ($type=Is date:K8:7)
			$type_as_text:="Date"
			
		: ($type=Is real:K8:4)
			$type_as_text:="Real"
			
		: ($type=Is longint:K8:6)
			$type_as_text:="Int32"
			
		: ($type=Is integer:K8:5)
			$type_as_text:="Int16"
			
		: ($type=Is BLOB:K8:12)
			$type_as_text:="BLOB"
			
		: ($type=Is object:K8:27)
			$type_as_text:="OBJ"
			
		: ($type=Is picture:K8:10)
			$type_as_text:="Pict"
			
		: ($type=Is integer 64 bits:K8:25)
			$type_as_text:="Int64"
			
		Else 
			$type_as_text:="** "+String:C10($type)
	End case 
	
	
Function _get_field_attributes_via_sql($field : Object)->$field_attributes : Object
	If ($field#Null:C1517)
		$field_attributes:=New object:C1471
		$field_attributes.is_REST:=Not:C34(Bool:C1537($field.hideInRest))
		$field_attributes.is_AutoIncrement:=Bool:C1537($field.autosequence)
		$field_attributes.is_AutoGenerate:=Bool:C1537($field.autogenerate)
		$field_attributes.is_Nullable:=Not:C34(Bool:C1537($field.notNull))
	End if 
	
	
Function _structure_IndexType2Name($index_type : Integer)->$index_type_name : Text
	ASSERT:C1129(Count parameters:C259=1)
	Case of 
		: ($index_type=-1)
			$index_type_name:="Multi"
			
		: ($index_type=1)
			$index_type_name:="B-tree"
			
		: ($index_type=3)
			$index_type_name:="Cluster B-tree"
			
		: ($index_type=7)
			$index_type_name:="Automatic"
			
		Else 
			$index_type_name:="Unknown Index Type #"+String:C10($index_type)
	End case 
	
	
Function _log($message : Text)
	//LogNamed_AppendToFile("cs.model_TableInformation"; Timestamp+": "+$message)
	