//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: CHART_SaveAsJPG
// 
// DESCRIPTION
//   
//
C_TEXT:C284($1; $chartID)
C_TEXT:C284($2; $vt_filePath)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (06/29/11)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$chartID:=$1
	$vt_filePath:=$2
	
	// Make sure that there is no file there already
	File_Delete($vt_filePath)
	
	SVG_SAVE_AS_PICTURE(CHART_SVG_GetMasterRef($chartID); $vt_filePath; ".jpg")
	//SVG_SAVE_AS_PICTURE (CHART_SVG_GetMasterRef ($chartID);$vt_filePath;".gif")
End if   // ASSERT
