//%attributes = {"invisible":true}
// Host_GetAssetInfo_GetProjForms
//   
// DESCRIPTION
//   Returns a list of project forms.
//
C_POINTER:C301($1; $ap_projectFormNamesPtr)
// ----------------------------------------------------
// CALLED BY
//   CODE_ExportProperties
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/02/2013)
//   Mod: DB (02/18/2014) - Use process vars rather than locals in the Execute Method call
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$ap_projectFormNamesPtr:=$1
	
	ARRAY TEXT:C222(at_tmpTextArray; 0)
	If (Structure file:C489(*)=Structure file:C489)  // Are we running locally?
		FORM GET NAMES:C1167(at_tmpTextArray; *)
	Else 
		C_BOOLEAN:C305($vb_noResult)
		EXECUTE METHOD:C1007("CodeAnalysis_GetAssetInfo"; $vb_noResult; "GetListOfProjectForms"; ->at_tmpTextArray)  // CodeAnalysis_GetAssetInfo("GetListOfProjectForms";->at_tmpTextArray)
	End if 
	
	//LogEvent_Write ("    IN "+Current method name+" returned "+String(Size of array(at_tmpTextArray))+".")
	
	COPY ARRAY:C226(at_tmpTextArray; $ap_projectFormNamesPtr->)
End if   // ASSERT
