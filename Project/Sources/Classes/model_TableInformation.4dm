/* 
A model that contains information on the tables and fields.
*/

Class constructor
	This:C1470._init()
	
	
/************ PUBLIC FUNCTIONS ************************/
Function Refresh()
	This:C1470._init()
	This:C1470._load_catalog_info()
	This:C1470._load_table_model()
	This:C1470._load_field_model()
	
	
Function GetTableFilteredList($name : Text)->$table_list : Collection
	If ($name="")
		$table_list:=This:C1470._table_model.copy()
	Else 
		$table_list:=This:C1470._table_model.query("table=:1"; $name+"@").copy()
	End if 
	
	
Function GetFieldFilteredList($name : Text)->$field_list : Collection
	If ($name="")
		$field_list:=This:C1470._field_model.copy()
	Else 
		$field_list:=This:C1470._field_model.query("table=:1 OR field=:1"; $name+"@").copy()
	End if 
	
	
/************ PRIVATE FUNCTIONS ************************/
Function _init()
	This:C1470._table_model:=New collection:C1472
	This:C1470._field_model:=New collection:C1472
	This:C1470._structure_catalog_model:=New collection:C1472
	
	
Function _load_catalog_info()
	var $structure_xml : Text
	EXPORT STRUCTURE:C1311($structure_xml)
	
	var $xml_source; $xml_Child_Ref; $xml_field_Ref : Text
	$xml_source:=DOM Parse XML variable:C720($structure_xml)
	
	var $i : Integer
	var $abort; $abort_table : Boolean
	var $childName; $childValue : Text
	var $siblingElemName; $siblingElemValue : Text
	This:C1470._structure_catalog_model:=New collection:C1472
	$abort:=False:C215
	Repeat 
		$abort_table:=False:C215
		$siblingElemName:=""
		If ($childName="")
			$xml_Child_Ref:=DOM Get first child XML element:C723($xml_source; $childName; $childValue)
		Else 
			$xml_Child_Ref:=DOM Get next sibling XML element:C724($xml_Child_Ref; $childName; $childValue)
		End if 
		
		Case of 
			: (OK=0)
				$abort:=True:C214
			: ($childName="Schema")  // ignore
			: ($childName="Index")  // ignore
			: ($childName="Base_extra")  // ignore
			: ($childName="Table")
				var $table_attributes : Object
				$table_attributes:=New object:C1471
				$table_attributes.fields:=New collection:C1472()
				XML_AddAttributesToObject($xml_Child_Ref; $table_attributes)
				This:C1470._structure_catalog_model.push($table_attributes)
				
				Repeat 
					If ($siblingElemName="")
						$xml_field_Ref:=DOM Get first child XML element:C723($xml_Child_Ref; $siblingElemName; $siblingElemValue)
					Else 
						$xml_field_Ref:=DOM Get next sibling XML element:C724($xml_field_Ref; $siblingElemName; $siblingElemValue)
					End if 
					
					Case of 
						: (OK=0)
							$abort_table:=True:C214
						: ($siblingElemName="Field")
							var $field_attributes : Object
							$field_attributes:=New object:C1471
							XML_AddAttributesToObject($xml_field_Ref; $field_attributes)
							$table_attributes.fields.push($field_attributes)
							
						: ($siblingElemName="primary_key")
						: ($siblingElemName="table_extra")
						Else 
							
					End case 
				Until ($abort_table)
				$xml_field_Ref:=""  // clear this
				
			Else 
				
		End case 
	Until ($abort)
	DOM CLOSE XML:C722($xml_source)
	
	
Function _load_table_model()
	var $table_no : Integer
	For ($table_no; 1; Get last table number:C254)  // use classic since only tables with PKs are known to orda
		If (Is table number valid:C999($table_no))
			This:C1470._table_model.push(This:C1470._get_detail_for_table($table_no))
		End if 
	End for 
	This:C1470._table_model:=This:C1470._table_model.orderBy("table asc")
	
	
Function _load_field_model()
	var $table_no; $field_no : Integer
	For ($table_no; 1; Get last table number:C254)  // use classic since only tables with PKs are known to orda
		If (Is table number valid:C999($table_no))
			For ($field_no; 1; Get last field number:C255($table_no))  // use classic since only tables with PKs are known to orda
				If (Is field number valid:C1000($table_no; $field_no))
					This:C1470._field_model.push(This:C1470._get_detail_for_field($table_no; $field_no))
				End if 
			End for 
		End if 
	End for 
	This:C1470._field_model:=This:C1470._field_model.orderBy("table asc, field asc")
	
	
Function _get_detail_for_field($table_no : Integer; $field_no : Integer)->$field_detail : Object
	var $table_detail; $field_attributes : Object
	var $type; $length : Integer
	var $isIndexed; $isUnique; $isInvisible : Boolean
	GET FIELD PROPERTIES:C258($table_no; $field_no; $type; $length; $isIndexed; $isUnique; $isInvisible)
	$table_detail:=This:C1470._table_model.query("tableNumber=:1"; $table_no)[0]
	
	$field_attributes:=This:C1470._get_field_attributes_via_sql($table_no; $field_no)
	
	$field_detail:=New object:C1471
	$field_detail.field:=Field name:C257($table_no; $field_no)
	$field_detail.name:="["+$table_detail.table+"]"+$field_detail.field
	$field_detail.table:=$table_detail.table
	$field_detail.tableNumber:=$table_no
	$field_detail.fieldNumber:=$field_no
	If ($table_detail.primaryKey_field_name#"")  // can use orda
		$field_detail.isPrimaryKey:=($table_detail.primaryKey_field_name=$field_detail.field)
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
	$field_detail.isNeverNullable:=This:C1470._is_field_never_nullable($table_no; $field_no)
	If ($field_detail.isIndexed)
		$field_detail.indexType:=Structure_IndexType2Name(Structure_GetFieldIndexType($table_no; $field_no))
	Else 
		$field_detail.indexType:="-"
	End if 
	$field_detail.notes:=""
	
	
Function _get_detail_for_table($table_no : Integer)->$table_details : Object
	var $isInvisible; $trigger_SaveNew; $trigger_SaveRec; $trigger_DelRec : Boolean
	GET TABLE PROPERTIES:C687($table_no; $isInvisible; $trigger_SaveNew; $trigger_SaveRec; $trigger_DelRec)
	$table_details:=New object:C1471
	$table_details.table:=Table name:C256($table_no)
	$table_details.tableNumber:=$table_no
	$table_details.is_logged:=This:C1470._is_table_logged($table_no)
	$table_details.is_invisible:=$isInvisible
	$table_details.triggers:=New object:C1471
	$table_details.triggers.on_saving_new:=$trigger_SaveNew
	$table_details.triggers.on_saving_existing:=$trigger_SaveRec
	$table_details.triggers.on_deleting:=$trigger_DelRec
	$table_details.exposed_to_REST:=This:C1470._is_table_REST_enabled($table_no)
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
	
	
Function _is_table_logged($table_no : Integer)->$table_is_logged : Boolean
	var $table_no_for_sql : Integer
	var $is_logged : Boolean
	$table_no_for_sql:=$table_no
	Begin SQL
		SELECT LOGGED
		FROM _USER_TABLES
		WHERE TABLE_ID=:$table_no_for_sql
		INTO :$is_logged;
	End SQL
	$table_is_logged:=$is_logged
	
	
Function _is_table_REST_enabled($table_no : Integer)->$is_enabled : Boolean
	var $table_no_for_sql : Integer
	var $is_set : Boolean
	$table_no_for_sql:=$table_no
	Begin SQL
		SELECT REST_AVAILABLE
		FROM _USER_TABLES
		WHERE TABLE_ID=:$table_no_for_sql
		INTO :$is_set;
	End SQL
	$is_enabled:=$is_set
	
	
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
	
	
Function _get_field_attributes_via_sql($table_no : Integer; $field_no : Integer)->$field_attributes : Object
	var $table_no_for_sql; $field_no_for_sql : Integer
	var $is_REST; $is_AutoIncrement; $is_AutoGenerate; $is_Nullable : Boolean
	$table_no_for_sql:=$table_no
	$field_no_for_sql:=$field_no
	Begin SQL
		SELECT Rest_Available, AutoIncrement, AutoGenerate, Nullable
		FROM _USER_COLUMNS
		WHERE Table_ID=:$table_no_for_sql AND Column_ID=:$field_no_for_sql
		INTO :$is_REST, :$is_AutoIncrement, :$is_AutoGenerate, :$is_Nullable;
	End SQL
	$field_attributes:=New object:C1471
	$field_attributes.is_REST:=$is_REST
	$field_attributes.is_AutoIncrement:=$is_AutoIncrement
	$field_attributes.is_AutoGenerate:=$is_AutoGenerate
	$field_attributes.is_Nullable:=$is_Nullable
	
	
Function _is_field_never_nullable($table_no : Integer; $field_no : Integer)->$is_never_null : Boolean
	var $tables; $fields : Collection
	$tables:=This:C1470._structure_catalog_model.query("id=:1"; String:C10($table_no))
	If ($tables.length=1)
		$fields:=$tables[0].fields.query("id=:1"; String:C10($field_no))
	End if 
	If ($fields.length=1)
		$is_never_null:=(String:C10($fields[0]["never_null"])="true")
	End if 