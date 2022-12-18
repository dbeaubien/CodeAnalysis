//%attributes = {"invisible":true}
// File_CreateFile (filePath; fileType) : docRef
// 
// DESCRIPTION
//   A generic method to create a file and properly set the
//   creator types. By default he file is set as a text file.
//
C_TEXT:C284($1; $vt_pathToCreateFileAt)
C_TEXT:C284($2; $vt_FileType)
C_TIME:C306($0; $vh_docRef)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (10/25/07)
// ----------------------------------------------------

$vh_docRef:=?00:00:00?  // Clear our var
If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 0; 3; Count parameters:C259))
	// ###################   Load parms   ##################
	If (Count parameters:C259>=1)
		$vt_pathToCreateFileAt:=$1
	Else 
		$vt_pathToCreateFileAt:=""
	End if 
	
	If (Count parameters:C259>=2)
		$vt_FileType:=$2
	Else 
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
	C_TEXT:C284($vt_docActuallyCreated)
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
	
End if   // ASSERT
$0:=$vh_docRef