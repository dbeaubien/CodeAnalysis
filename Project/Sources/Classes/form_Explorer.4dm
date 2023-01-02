/* Form controller for the "Explorer_d" form */

Class constructor($form : Object)
	This:C1470._form:=$form
	This:C1470._setup_tabControl()
	This:C1470._model_tableInfo:=cs:C1710.model_TableInformation.new()
	This:C1470.RefreshStructureInfo()
	This:C1470.RefreshIndexedFieldInfo()
	
	
/****** PUBLIC FUNCTIONS ******/
Function RefreshStructureInfo()
	This:C1470._model_tableInfo.Refresh()
	
	
Function RefreshIndexedFieldInfo()
	This:C1470._form.filteredIndexedFieldList:=This:C1470._model_tableInfo.GetFieldFilteredList("")\
		.query("isIndexed=:1"; True:C214)
	This:C1470._enhance_field_model_collection(This:C1470._form.filteredIndexedFieldList; "1")
	var $field_detail : Object
	var $indexUsageRatio : Real
	var $numberOfRecordsInTable : Integer
	For each ($field_detail; This:C1470._form.filteredIndexedFieldList)
		$numberOfRecordsInTable:=Records in table:C83(Table:C252($field_detail.tableNumber)->)
		If ($numberOfRecordsInTable=0)
			$field_detail.index_analysis_notes:="n/a - Table is empty"
		Else 
			$indexUsageRatio:=Structure_GetFieldIndexRatio($field_detail.tableNumber; $field_detail.fieldNumber)*100
			Case of 
				: ($indexUsageRatio>=100)
					$field_detail.index_analysis_notes:="ALL values are unique"
					
				: ($indexUsageRatio<1)
					$field_detail.index_analysis_notes:="Less than 1% of the values are unique"
					
				Else 
					$field_detail.index_analysis_notes:=String:C10($indexUsageRatio; "#0.000")+"% of the values are unique"
			End case 
		End if 
	End for each 
	
	
Function FocusOnSearchFieldOnPageNo($page_no : Integer)
	Case of 
		: ($page_no=1)
			EXECUTE METHOD IN SUBFORM:C1085("MethodSearchPicker"; "FocusOnObject"; *; \
				Choose:C955(Is macOS:C1572; "SearchText_Mac"; "SearchText_Win"))
		: ($page_no=2)
			EXECUTE METHOD IN SUBFORM:C1085("StructureFilterThingy"; "FocusOnObject"; *; \
				Choose:C955(Is macOS:C1572; "SearchText_Mac"; "SearchText_Win"))
		: ($page_no=3)
			EXECUTE METHOD IN SUBFORM:C1085("TableFilterThingy"; "FocusOnObject"; *; \
				Choose:C955(Is macOS:C1572; "SearchText_Mac"; "SearchText_Win"))
	End case 
	
	
Function FilterTableList($starts_with : Text)
	This:C1470._form.filteredTableList:=This:C1470._model_tableInfo.GetTableFilteredList($starts_with)
	var $table_detail : Object
	For each ($table_detail; This:C1470._form.filteredTableList)
		$table_detail.logged_asText:=Choose:C955($table_detail.is_logged; "Yes"; "-")
		$table_detail.rest_asText:=Choose:C955($table_detail.exposed_to_REST; "Yes"; "-")
		$table_detail.on_new_trigger:=Choose:C955($table_detail.triggers.on_saving_new; "✓"; "-")
		$table_detail.on_save_trigger:=Choose:C955($table_detail.triggers.on_saving_existing; "✓"; "-")
		$table_detail.on_delete_trigger:=Choose:C955($table_detail.triggers.on_deleting; "✓"; "-")
		
		$table_detail.meta:=New object:C1471
		$table_detail.meta.cell:=New object:C1471
		If (Not:C34($table_detail.is_logged))
			$table_detail.meta.cell.is_logged:=New object:C1471("fill"; "#FFB9B9")  // red
		End if 
		If ($table_detail.exposed_to_REST)
			$table_detail.meta.cell.exposed_to_REST:=New object:C1471
			$table_detail.meta.cell.exposed_to_REST.fill:="#B9FFB9"  // green
			//$table_detail.meta.cell.exposed_to_REST.fontWeight:="bold"
		End if 
		If ($table_detail.primaryKey_field_name="")
			$table_detail.meta.cell.primaryKey_field_name:=New object:C1471
			$table_detail.meta.cell.primaryKey_field_name.fill:="#FFB9B9"  // red
		End if 
		If ($table_detail.is_invisible)
			$table_detail.meta.cell.table:=New object:C1471
			$table_detail.meta.cell.table.fontStyle:="italic"
			$table_detail.meta.cell.table.stroke:="#777"
		End if 
	End for each 
	
	
Function FilterFieldList($starts_with : Text)
	This:C1470._form.filteredFieldList:=This:C1470._model_tableInfo.GetFieldFilteredList($starts_with)
	This:C1470._enhance_field_model_collection(This:C1470._form.filteredFieldList; "")
	
	
	
/****** PRIVATE FUNCTIONS ******/
Function _setup_tabControl()
	This:C1470._form.tabControl:=New object:C1471
	This:C1470._form.tabControl.values:=New collection:C1472()
	This:C1470._form.tabControl.values.push(":xliff:TabLabel_Methods")
	This:C1470._form.tabControl.values.push(":xliff:TabLabel_FieldStructure")
	This:C1470._form.tabControl.values.push(":xliff:TabLabel_TableStructure")
	This:C1470._form.tabControl.values.push(":xliff:TabLabel_Indexes")
	This:C1470._form.tabControl.values.push("Summary")
	This:C1470._form.tabControl.index:=0  //start on page 1
	
	
Function _enhance_field_model_collection($field_collection : Collection; $suffix : Text)
	var $field_detail; $name_meta : Object
	var $notes : Collection
	$notes:=New collection:C1472()
	For each ($field_detail; $field_collection)
		$field_detail.unique_asText:=Choose:C955($field_detail.isUnique; "Yes"; "-")
		$field_detail.invisible_asText:=Choose:C955($field_detail.isInvisible; "Yes"; "-")
		$field_detail.rest_asText:=Choose:C955($field_detail.exposed_to_REST; "Yes"; "-")
		
		$notes.clear()
		If ($field_detail.isAutoIncrement)
			$notes.push("Auto Increment")
		End if 
		If ($field_detail.isAutoGenerate)
			$notes.push("Auto Generate")
		End if 
		If (Not:C34($field_detail.isNullable))
			$notes.push("Reject NULL")
		End if 
		$field_detail.notes:=$notes.join(", ")
		$field_detail.index_analysis_notes:=" ** waiting for index analysis **"
		
		$field_detail.meta:=New object:C1471
		$field_detail.meta.cell:=New object:C1471
		If ($field_detail.isPrimaryKey) | ($field_detail.isIndexed)
			$name_meta:=New object:C1471
			$field_detail.meta.cell["name"+$suffix]:=$name_meta
			$name_meta.fontWeight:="bold"
			If ($field_detail.isPrimaryKey)
				$name_meta.textDecoration:="underline"
			End if 
		End if 
		
	End for each 