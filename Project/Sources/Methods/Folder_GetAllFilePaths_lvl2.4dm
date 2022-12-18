//%attributes = {"invisible":true}
// Folder_GetAllFilePaths_lvl2 (SrcPath; FilePaths{; ignoreNames})
// Folder_GetAllFilePaths_lvl2 (text, arrayPtr{, arrayPtr})
//
// DESCRIPTION
//   This method populates FilePaths with all the files
//   that exist within the SrcPath. Internal folders are
//   recursed.
//
//   This method calls itself.
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
	
	// Load the files
	ARRAY TEXT:C222($at_files; 0)  // testy
	DOCUMENT LIST:C474($vt_pathToFolderRoot; $at_files)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($at_files))
		If (Count parameters:C259>=3)
			If (Find in array:C230($at_ignoreTheseNamesPtr->; $at_files{$i})<1)  // Ignore any files that match one of these names
				APPEND TO ARRAY:C911($at_filePathsPtr->; $vt_pathToFolderRoot+$at_files{$i})
			End if 
		Else 
			APPEND TO ARRAY:C911($at_filePathsPtr->; $vt_pathToFolderRoot+$at_files{$i})
		End if 
	End for 
	
	// Recursively call for each folder
	ARRAY TEXT:C222($at_files; 0)
	FOLDER LIST:C473($vt_pathToFolderRoot; $at_files)
	For ($i; 1; Size of array:C274($at_files))
		If (Count parameters:C259>=3)
			If (Find in array:C230($at_ignoreTheseNamesPtr->; $at_files{$i})<1)  // Ignore any files that match one of these names
				Folder_GetAllFilePaths_lvl2($vt_pathToFolderRoot+$at_files{$i}+Folder separator:K24:12; $at_filePathsPtr; $at_ignoreTheseNamesPtr)
			End if 
		Else 
			Folder_GetAllFilePaths_lvl2($vt_pathToFolderRoot+$at_files{$i}+Folder separator:K24:12; $at_filePathsPtr)
		End if 
	End for 
	
End if   // ASSERT