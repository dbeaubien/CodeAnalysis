//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: File_DoesExist (path to file) : does exist
// 
// DESCRIPTION:
//   Returns true if the file exists. It will create any directories if
//   are missing.
// ----------------------------------------------------
// PARAMETERS:
//   $1: path to file
// RETURNS:
//   $0: does exist
// ----------------------------------------------------
// MODIFICATION HISTORY:
//   Added: DB (7/17/03 @ 15:46:39)
// ----------------------------------------------------

C_BOOLEAN:C305($0; $File_vb_doesExist)
$File_vb_doesExist:=False:C215

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	C_TEXT:C284($1; $File_vt_fullPath)
	$File_vt_fullPath:=$1
	
	If ($File_vt_fullPath#"")
		// make sure that the directory exists that this file is supposed to be in
		Folder_VerifyExistance(Folder_ParentName($File_vt_fullPath))
		
		If (Test path name:C476($File_vt_fullPath)=Is a document:K24:1)
			$File_vb_doesExist:=True:C214
		End if 
	End if 
End if   // ASSERT

$0:=$File_vb_doesExist