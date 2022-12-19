Class constructor($form : Object)
	This:C1470._form:=$form
	This:C1470._setup_tabControl()
	
	
/****** PUBLIC FUNCTIONS ******/
Function FocusOnSearchFieldOnPageNo($page_no : Integer)
	Case of 
		: ($page_no=1)
			EXECUTE METHOD IN SUBFORM:C1085("MethodSearchPicker"; "FocusOnObject"; *; \
				Choose:C955(Is macOS:C1572; "SearchText_Mac"; "SearchText_Win"))
		: ($page_no=2)
			EXECUTE METHOD IN SUBFORM:C1085("StructureFilterThingy"; "FocusOnObject"; *; \
				Choose:C955(Is macOS:C1572; "SearchText_Mac"; "SearchText_Win"))
	End case 
	
	
/****** PRIVATE FUNCTIONS ******/
Function _setup_tabControl()
	This:C1470._form.tabControl:=New object:C1471
	This:C1470._form.tabControl.values:=New collection:C1472()
	This:C1470._form.tabControl.values.push(":xliff:TabLabel_Methods")
	This:C1470._form.tabControl.values.push(":xliff:TabLabel_FieldStructure")
	This:C1470._form.tabControl.values.push(":xliff:TabLabel_TableStructure")
	This:C1470._form.tabControl.values.push("Summary")
	This:C1470._form.tabControl.index:=0  //start on page 1
	