//%attributes = {"invisible":true,"shared":true}
// CA_Pref_SetExportFolder (exportFolderPath) 
// 
// DESCRIPTION
//   Using the method will set the root folder where the
//   component will export all of it's files and folders to.
//
#DECLARE($vt_exportFolderPath : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	Pref_SetPrefString("destinationFolder v2"; $vt_exportFolderPath)
End if 