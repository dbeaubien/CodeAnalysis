//%attributes = {"invisible":true}
// ExportExtras_GetFolderPathsArr (folderPathsArray; actionsPathsArray) 
// ExportExtras_GetFolderPathsArr (pointer; pointer)
//
// DESCRIPTION
//   Populates an array of the paths to the folders that
//   the user has defined as being part of the export.
//
C_POINTER:C301($1; $folderPathsArray)
C_POINTER:C301($2; $actionFolderPathsArray)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/15/2017)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=2))
	$folderPathsArray:=$1
	$actionFolderPathsArray:=$2
	
	Pref_GetPrefTextArray("Extra Folder"; $folderPathsArray)
	Pref_GetPrefTextArray("Extra Folder action"; $actionFolderPathsArray)
	
	// Make sure that this is defined properly
	If (Size of array:C274($actionFolderPathsArray->)<Size of array:C274($folderPathsArray->))
		Array_SetSize(Size of array:C274($folderPathsArray->); $actionFolderPathsArray)
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274($actionFolderPathsArray->))
			If ($actionFolderPathsArray->{$i}="")
				$actionFolderPathsArray->{$i}:="Copy"
			End if 
		End for 
		
		Pref_SetPrefTextArray("Extra Folder action"; ->$actionFolderPathsArray)
	End if 
	
	For ($i; 1; Size of array:C274($folderPathsArray->))
		$folderPathsArray->{$i}:=Folder_GetPathFrmRelativeToStct($folderPathsArray->{$i})
	End for 
	
End if 
