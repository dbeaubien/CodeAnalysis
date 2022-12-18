//%attributes = {"invisible":true,"shared":true}
// CA_Pref_SetExportFolder (exportFolderPath) 
// CA_Pref_SetExportFolder (text) 
// 
// DESCRIPTION
//   Using the method will set the root folder where the
//   component will export all of it's files and folders to.
//
C_TEXT:C284($1; $vt_exportFolderPath)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/26/2017)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_exportFolderPath:=$1
	
	Pref_SetPrefString("destinationFolder v2"; $vt_exportFolderPath)
End if   // ASSERT