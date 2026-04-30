//%attributes = {"invisible":true}
// ExportExtras_GetFolderPathsArr (folderPathsArray; actionsPathsArray) 
//
// DESCRIPTION
//   Populates an array of the paths to the folders that
//   the user has defined as being part of the export.
//
#DECLARE($folderPathsArray : Pointer; $actionFolderPathsArray : Pointer)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=2))
	Pref_GetPrefTextArray("Extra Folder"; $folderPathsArray)
	Pref_GetPrefTextArray("Extra Folder action"; $actionFolderPathsArray)
	
	// Make sure that this is defined properly
	If (Size of array:C274($actionFolderPathsArray->)<Size of array:C274($folderPathsArray->))
		Array_SetSize(Size of array:C274($folderPathsArray->); $actionFolderPathsArray)
		var $i : Integer
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
