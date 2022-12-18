//%attributes = {"invisible":true}
// Folder_GetAllFilePaths (SrcPath; FilePaths{; ignoreNames})
// Folder_GetAllFilePaths (text, arrayPtr{, arrayPtr})
//
// DESCRIPTION
//   This method populates FilePaths with all the files
//   that exist within the SrcPath. internal folders are
//   recursed.
//
C_TEXT:C284($1; $vt_pathToFolderRoot)
C_POINTER:C301($2; $at_filePathsPtr)
C_POINTER:C301($3; $at_ignoreTheseNamesPtr)  // OPTIONAL
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/01/2012)
//   Mod by: Dani Beaubien (01/23/2016) - Support Ingnoring certain file/folder names
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 2; 3; Count parameters:C259))
	$vt_pathToFolderRoot:=$1
	$at_filePathsPtr:=$2
	If (Count parameters:C259>=3)
		$at_ignoreTheseNamesPtr:=$3
	End if 
	
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
End if   // ASSERT

