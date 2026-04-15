//%attributes = {"invisible":true}
// Host_GetAssetInfo_GetProjForms
//   
// DESCRIPTION
//   Returns a list of project forms.
//
#DECLARE($ap_projectFormNamesPtr : Pointer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	ARRAY TEXT:C222(at_tmpTextArray; 0)
	If (Structure file:C489(*)=Structure file:C489)  // Are we running locally?
		FORM GET NAMES:C1167(at_tmpTextArray; *)
	Else 
		var $vb_noResult : Boolean
		EXECUTE METHOD:C1007("CodeAnalysis_GetAssetInfo"; $vb_noResult; "GetListOfProjectForms"; ->at_tmpTextArray)  // CodeAnalysis_GetAssetInfo("GetListOfProjectForms";->at_tmpTextArray)
	End if 
	
	//LogEvent_Write ("    IN "+Current method name+" returned "+String(Size of array(at_tmpTextArray))+".")
	
	COPY ARRAY:C226(at_tmpTextArray; $ap_projectFormNamesPtr->)
End if 
