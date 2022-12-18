//%attributes = {"invisible":true,"preemptive":"capable"}
// Folder_DeleteFilesNotInSource (folderToScan, validFileNamesArr)
// Folder_DeleteFilesNotInSource (text, pointer)
//
// DESCRIPTION
//   Scans the specified folder and deletes any file that
//   was not included as a valid file name.
//
C_TEXT:C284($1; $folderToScan)
C_POINTER:C301($2; $validFileNamesArr)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/15/2017)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=2))
	$folderToScan:=$1
	$validFileNamesArr:=$2
	
	// Grab the list of the documents from the destination
	ARRAY TEXT:C222($existingFilesArr; 0)
	DOCUMENT LIST:C474($folderToScan; $existingFilesArr)
	
	// Delete the files that do not exist in the source
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($existingFilesArr))
		If ($existingFilesArr{$i}#".DS_Store")
			If (Find in array:C230($validFileNamesArr->; $existingFilesArr{$i})<1)
				DELETE DOCUMENT:C159($folderToScan+$existingFilesArr{$i})
			End if 
		End if 
	End for 
	
End if 