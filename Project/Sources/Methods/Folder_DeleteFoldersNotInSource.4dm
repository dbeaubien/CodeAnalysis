//%attributes = {"invisible":true}
// Folder_DeleteFoldersNotInSource (folderToScan, validFolderNamesArr)
// Folder_DeleteFoldersNotInSource (text, pointer)
//
// DESCRIPTION
//   Scans the specified folder and deletes any folders that
//   was not included as a valid folder name.
//
C_TEXT:C284($1; $folderToScan)
C_POINTER:C301($2; $validFolderNamesArr)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/15/2017)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=2))
	$folderToScan:=$1
	$validFolderNamesArr:=$2
	
	// Grab the list of the folders from the destination
	ARRAY TEXT:C222($existingFoldersArr; 0)
	FOLDER LIST:C473($folderToScan; $existingFoldersArr)
	
	// Delete the files that do not exist in the source
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($existingFoldersArr))
		If (Find in array:C230($validFolderNamesArr->; $existingFoldersArr{$i})<1)
			Folder_Delete($folderToScan+$existingFoldersArr{$i})
		End if 
	End for 
	
End if 