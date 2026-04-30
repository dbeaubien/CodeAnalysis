//%attributes = {"invisible":true}
// Host_GetAssetInfo_GetTableForms
//   
// DESCRIPTION
//   Returns a list of table forms.
//
#DECLARE($vl_tableNo : Integer; $ap_tableFormNamesPtr : Pointer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	
	// Fetch the form names from the host database
	ARRAY TEXT:C222(at_tmpTextArray; 0)
	If (Structure file:C489(*)=Structure file:C489)  // Are we running locally?
		FORM GET NAMES:C1167(Table:C252($vl_tableNo)->; at_tmpTextArray; *)
	Else 
		var $vb_noResult : Boolean
		var vl_tmpLongint : Integer
		vl_tmpLongint:=$vl_tableNo
		EXECUTE METHOD:C1007("CodeAnalysis_GetAssetInfo"; $vb_noResult; "GetListOfTableForms"; ->vl_tmpLongint; ->at_tmpTextArray)  // CodeAnalysis_GetAssetInfo("GetListOfTableForms";->$vl_tableNo;->at_projectFormNames)
	End if 
	
	//LogEvent_Write ("    IN "+Current method name+" returned "+String(Size of array(at_tmpTextArray))+" for table "+Table name($vl_tableNo)+".")
	
	COPY ARRAY:C226(at_tmpTextArray; $ap_tableFormNamesPtr->)
End if 
