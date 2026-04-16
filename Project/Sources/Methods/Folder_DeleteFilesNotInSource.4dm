//%attributes = {"invisible":true,"preemptive":"capable"}
// Folder_DeleteFilesNotInSource (folderToScan, validFileNamesArr)
//
// DESCRIPTION
//   Scans the specified folder and deletes any file that
//   was not included as a valid file name.
//
#DECLARE($folderToScan : Text; $validFileNamesArr : Pointer)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

// Grab the list of the documents from the destination
ARRAY TEXT:C222($existingFilesArr; 0)
DOCUMENT LIST:C474($folderToScan; $existingFilesArr)

// Delete the files that do not exist in the source
var $i : Integer
For ($i; 1; Size of array:C274($existingFilesArr))
	If ($existingFilesArr{$i}#".DS_Store")
		If (Find in array:C230($validFileNamesArr->; $existingFilesArr{$i})<1)
			DELETE DOCUMENT:C159($folderToScan+$existingFilesArr{$i})
		End if 
	End if 
End for 
