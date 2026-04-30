//%attributes = {"invisible":true}
// Folder_DoesExist (path to folder) : does exist
// 
// DESCRIPTION:
//   Returns true if the folder exists
//
#DECLARE($Folder_vt_fullPath : Text)->$Folder_vb_doesExist : Boolean
// ----------------------------------------------------
$Folder_vb_doesExist:=False:C215

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	If ($Folder_vt_fullPath#"") && (Test path name:C476($Folder_vt_fullPath)=Is a folder:K24:2)
		$Folder_vb_doesExist:=True:C214
	End if 
End if 

