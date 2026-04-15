//%attributes = {"invisible":true}
// Folder_VerifyExistance (path to folder)
// 
// DESCRIPTION:
//   Creates a folder if it does not exist. If necessary, it will
//   recursively create the parent folders as well.
//
#DECLARE($Folder_vt_fullPath : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	If ($Folder_vt_fullPath#"") && (Not:C34(Folder_DoesExist($Folder_vt_fullPath)))
		
		// recursively call this routine to make sure that the parent folders exist as well
		Folder_VerifyExistance(Folder_ParentName($Folder_vt_fullPath))
		
		// create it
		CREATE FOLDER:C475($Folder_vt_fullPath)
	End if 
End if 
