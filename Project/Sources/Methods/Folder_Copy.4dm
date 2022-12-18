//%attributes = {"invisible":true}
// Folder_Copy (srcFolderPath; dstFolderPath{; subFoldersToSkip})
// Folder_Copy (text; text{; pointer})
//
// DESCRIPTION
//   Does an intelligent copy. Will only copy the items 
//   that are "different" than what is in the source.
//
//   Any "extra" files or folders in the destination that
//   are not in the source are deleted.
//
C_TEXT:C284($1; $vt_srcFolderPath)
C_TEXT:C284($2; $vt_dstFolderPath)
C_COLLECTION:C1488($3; $subFoldersToSkip)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/08/2012)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=3)
$vt_srcFolderPath:=Folder_EnsureEndsInSeparator($1)
$vt_dstFolderPath:=Folder_EnsureEndsInSeparator($2)
$subFoldersToSkip:=$3

ARRAY TEXT:C222($subFoldersToSkipArr; 0)
If ($subFoldersToSkip.length>0)
	COLLECTION TO ARRAY:C1562($subFoldersToSkip; $subFoldersToSkipArr)
End if 

// Store away our current on error settings
OnErr_ClearError
C_TEXT:C284($vt_onErrorMethod)
$vt_onErrorMethod:=Method called on error:C704
ON ERR CALL:C155("OnErr_GENERIC")

// Make sure that our paths are still valid
If (Length:C16($vt_srcFolderPath)>0) & (Length:C16($vt_dstFolderPath)>0)
	Folder_VerifyExistance($vt_srcFolderPath)
	Folder_VerifyExistance($vt_dstFolderPath)
	
	// Grab the list of the documents and folders from the source
	ARRAY TEXT:C222($at_containedDocuments; 0)
	ARRAY TEXT:C222($at_containedFolders; 0)
	DOCUMENT LIST:C474($vt_srcFolderPath; $at_containedDocuments)
	FOLDER LIST:C473($vt_srcFolderPath; $at_containedFolders)
	Array_RemoveElementIfExists(->$at_containedDocuments; ".DS_Store")
	
	Folder_DeleteFilesNotInSource($vt_dstFolderPath; ->$at_containedDocuments)
	Folder_DeleteFoldersNotInSource($vt_dstFolderPath; ->$at_containedFolders)
	
	// Loop through each file and copy what is "different"
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($at_containedDocuments))
		If (File_isDifferent($vt_srcFolderPath+$at_containedDocuments{$i}; $vt_dstFolderPath+$at_containedDocuments{$i}))
			File_Delete($vt_dstFolderPath+$at_containedDocuments{$i})
			COPY DOCUMENT:C541($vt_srcFolderPath+$at_containedDocuments{$i}; $vt_dstFolderPath+$at_containedDocuments{$i})
		End if 
	End for 
	
	// Loop through each sub folder and do the copy
	For ($i; 1; Size of array:C274($at_containedFolders))
		OnErr_ClearError
		If (Find in array:C230($subFoldersToSkipArr; $vt_srcFolderPath+$at_containedFolders{$i})<1)
			Folder_Copy($vt_srcFolderPath+$at_containedFolders{$i}; $vt_dstFolderPath+$at_containedFolders{$i}; $subFoldersToSkip)
		End if 
	End for 
	
Else 
	ALERT:C41("One or both of the paths is empty.")
End if 

OnErr_ClearError
ON ERR CALL:C155($vt_onErrorMethod)  // restore our method