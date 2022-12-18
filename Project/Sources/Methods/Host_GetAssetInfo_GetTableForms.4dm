//%attributes = {"invisible":true}
// Host_GetAssetInfo_GetTableForms
//   
// DESCRIPTION
//   Returns a list of table forms.
//
C_LONGINT:C283($1; $vl_tableNo)
C_POINTER:C301($2; $ap_tableFormNamesPtr)
// ----------------------------------------------------
// CALLED BY
//   CODE_ExportProperties
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/02/2013)
//   Mod: DB (02/18/2014) - Use process vars rather than locals in the Execute Method call
//   Mod: DB (09/02/2015) - Use updated "FORM GET NAMES" v14 command
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$vl_tableNo:=$1
	$ap_tableFormNamesPtr:=$2
	
	// Fetch the form names from the host database
	ARRAY TEXT:C222(at_tmpTextArray; 0)
	If (Structure file:C489(*)=Structure file:C489)  // Are we running locally?
		FORM GET NAMES:C1167(Table:C252($vl_tableNo)->; at_tmpTextArray; *)
	Else 
		C_BOOLEAN:C305($vb_noResult)
		C_LONGINT:C283(vl_tmpLongint)
		vl_tmpLongint:=$vl_tableNo
		EXECUTE METHOD:C1007("CodeAnalysis_GetAssetInfo"; $vb_noResult; "GetListOfTableForms"; ->vl_tmpLongint; ->at_tmpTextArray)  // CodeAnalysis_GetAssetInfo("GetListOfTableForms";->$vl_tableNo;->at_projectFormNames)
	End if 
	
	//LogEvent_Write ("    IN "+Current method name+" returned "+String(Size of array(at_tmpTextArray))+" for table "+Table name($vl_tableNo)+".")
	
	COPY ARRAY:C226(at_tmpTextArray; $ap_tableFormNamesPtr->)
End if   // ASSERT
