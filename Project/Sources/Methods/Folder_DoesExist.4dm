//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: Folder_DoesExist (path to folder) : does exist
// 
// DESCRIPTION:
//   Returns true if the folder exists
// ----------------------------------------------------
// PARAMETERS:
//   $1: path to folder
// RETURNS:
//   $0: does exist
// ----------------------------------------------------
// MODIFICATION HISTORY:
//   Added: DB (7/17/03 @ 15:46:39)
// ----------------------------------------------------

C_BOOLEAN:C305($0; $Folder_vb_doesExist)
$Folder_vb_doesExist:=False:C215

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	C_TEXT:C284($1; $Folder_vt_fullPath)
	$Folder_vt_fullPath:=$1
	
	If ($Folder_vt_fullPath#"")
		If (Test path name:C476($Folder_vt_fullPath)=Is a folder:K24:2)
			$Folder_vb_doesExist:=True:C214
		End if 
	End if 
End if   // ASSERT

$0:=$Folder_vb_doesExist