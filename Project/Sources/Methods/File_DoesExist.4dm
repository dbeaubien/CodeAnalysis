//%attributes = {"invisible":true}
// File_DoesExist (path to file) : does exist
// 
// DESCRIPTION:
//   Returns true if the file exists. It will create any directories if
//   are missing.
// 
#DECLARE($file_platformPath : Text)->$does_exists : Boolean
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$does_exists:=False:C215

If ($file_platformPath#"")
	// make sure that the directory exists that this file is supposed to be in
	Folder_VerifyExistance(Folder_ParentName($file_platformPath))
	
	If (Test path name:C476($file_platformPath)=Is a document:K24:1)
		$does_exists:=True:C214
	End if 
End if 
