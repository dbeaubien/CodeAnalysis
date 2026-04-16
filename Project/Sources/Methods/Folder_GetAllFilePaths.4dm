//%attributes = {"invisible":true}
// Folder_GetAllFilePaths (SrcPath; FilePaths{; ignoreNames})
//
// DESCRIPTION
//   This method populates FilePaths with all the files
//   that exist within the SrcPath. internal folders are
//   recursed.
//
#DECLARE($vt_pathToFolderRoot : Text\
; $at_filePathsPtr : Pointer\
; $at_ignoreTheseNamesPtr : Pointer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 2; 3; Count parameters:C259))
	Array_Empty($at_filePathsPtr)
	If ($vt_pathToFolderRoot#"")
		
		// ensure string ends with a folder separator
		If (Substring:C12($vt_pathToFolderRoot; Length:C16($vt_pathToFolderRoot); 1)#Folder separator:K24:12)
			$vt_pathToFolderRoot:=$vt_pathToFolderRoot+Folder separator:K24:12
		End if 
		
		If (Count parameters:C259>=3)
			Folder_GetAllFilePaths_lvl2($vt_pathToFolderRoot; $at_filePathsPtr; $at_ignoreTheseNamesPtr)
		Else 
			Folder_GetAllFilePaths_lvl2($vt_pathToFolderRoot; $at_filePathsPtr)
		End if 
		SORT ARRAY:C229($at_filePathsPtr->; >)
	End if 
End if 
