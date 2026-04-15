//%attributes = {"invisible":true}
// Folder_Delete
// 
// DESCRIPTION
//  This routine will recursively delete files and folders  
//  including the folder you pass in. Use with care as
//  this is NOT UNDOABLE and has NO ERROR CHECKING!
//  Don't say I didn't warn you.
//
#DECLARE($vt_folderPath : Text)  // Path of the folder to be deleted. 
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	If ($vt_folderPath#"")
		var $vt_curOnErrMethod : Text  // Added: DB (2005.08.05 @ 09:01:57) -  better error handling
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
	
End if 
