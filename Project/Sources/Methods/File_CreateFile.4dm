//%attributes = {"invisible":true}
// File_CreateFile (filePath; fileType) : docRef
// 
// DESCRIPTION
//   A generic method to create a file and properly set the
//   creator types. By default he file is set as a text file.
//
#DECLARE($vt_pathToCreateFileAt : Text\
; $vt_FileType : Text)->$vh_docRef : Time
// ----------------------------------------------------

$vh_docRef:=?00:00:00?  // Clear our var
If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 0; 3; Count parameters:C259))
	If ($vt_FileType="")
		$vt_FileType:=File_DeriveFileTypeFromName($vt_pathToCreateFileAt)
		If ($vt_FileType="")
			If (Is Windows:C1573)
				$vt_FileType:="TXT"
			Else 
				$vt_FileType:="TEXT"
			End if 
		End if 
	End if 
	
	
	// ###################   Do the deed  ##################
	var $vt_docActuallyCreated : Text
	$vh_docRef:=Create document:C266($vt_pathToCreateFileAt; $vt_FileType)
	If (OK=1)
		$vt_docActuallyCreated:=Document
		CLOSE DOCUMENT:C267($vh_docRef)
		
		// Make sure that the name we specified (if any) is the name of the created file
		If ($vt_pathToCreateFileAt#"") & ($vt_pathToCreateFileAt#$vt_docActuallyCreated)
			MOVE DOCUMENT:C540($vt_docActuallyCreated; $vt_pathToCreateFileAt)
			$vt_docActuallyCreated:=$vt_pathToCreateFileAt
		End if 
		
		$vh_docRef:=Open document:C264($vt_docActuallyCreated)
	Else 
		$vh_docRef:=-1
	End if 
	
End if 
$0:=$vh_docRef