//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: Folder_Delete
// 
// DESCRIPTION
//  This routine will recursively delete files and folders  
//  including the folder you pass in. Use with care as
//  this is NOT UNDOABLE and has NO ERROR CHECKING!
//  Don't say I didn't warn you.
//
// PARAMETERS:
C_TEXT:C284($1; $vt_folderPath)  // Path of the folder to be deleted. 
// RETURNS:
//   none
// ----------------------------------------------------
// HISTORY
//   Created by: DB (05/31/06)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_folderPath:=$1
	
	If ($vt_folderPath#"")
		C_TEXT:C284($vt_curOnErrMethod)  // Added: DB (2005.08.05 @ 09:01:57) -  better error handling
		$vt_curOnErrMethod:=Method called on error:C704
		ON ERR CALL:C155("OnErr_GENERIC")
		OnErr_ClearError
		
		If (Substring:C12($vt_folderPath; Length:C16($vt_folderPath); 1)=Folder separator:K24:12)
			$vt_folderPath:=Substring:C12($vt_folderPath; 1; Length:C16($vt_folderPath)-1)
		End if 
		
		
		If (Folder_DoesExist($vt_folderPath))
			Folder_EmptyContents($vt_folderPath)  // 1st empty the folder
			DELETE FOLDER:C693($vt_folderPath)  // and then delete the folder
		End if 
		
		OnErr_ClearError
		ON ERR CALL:C155($vt_curOnErrMethod)  // Added: DB (2005.08.05 @ 09:01:57) -  better error handling
	End if 
	
End if   // ASSERT
