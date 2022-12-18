//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: Folder_EmptyContents
// 
// DESCRIPTION
//   This method deletes all the files within the specified folder.
//
// PARAMETERS:
C_TEXT:C284($1; $vt_folderPath)
//
// RETURNS:
//   none
// ----------------------------------------------------
//   Created by: DB (02/03/07)
//   Mod: DB (12/11/2010) - Modify to remove subfolders as well.
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_folderPath:=$1
	
	// Make sure we have a nice ending to our string, We will add one below
	If (Substring:C12($vt_folderPath; Length:C16($vt_folderPath); 1)=Folder separator:K24:12)
		$vt_folderPath:=Substring:C12($vt_folderPath; 1; Length:C16($vt_folderPath)-1)
	End if 
	
	If (Folder_DoesExist($vt_folderPath))
		$vt_folderPath:=$vt_folderPath+Folder separator:K24:12  // ready for our code below
		
		C_TEXT:C284($vt_currentOnErrorMethod)
		$vt_currentOnErrorMethod:=Method called on error:C704
		ON ERR CALL:C155("OnErr_GENERIC")
		
		C_LONGINT:C283($PROC_vL_Count)
		ARRAY TEXT:C222($PROC_aT_Folders; 0)
		ARRAY TEXT:C222($PROC_aT_Files; 0)
		
		//First let's just merrily delete all of the documents in this folder...
		DOCUMENT LIST:C474($vt_folderPath; $PROC_aT_Files)
		For ($PROC_vL_Count; 1; Size of array:C274($PROC_aT_Files))
			DELETE DOCUMENT:C159($vt_folderPath+$PROC_aT_Files{$PROC_vL_Count})
		End for 
		//
		//Now that there are only folders left, let's recursively delete them and all thier po' li'l chillen...
		FOLDER LIST:C473($vt_folderPath; $PROC_aT_Folders)
		For ($PROC_vL_Count; 1; Size of array:C274($PROC_aT_Folders))
			Folder_Delete($vt_folderPath+$PROC_aT_Folders{$PROC_vL_Count}+Folder separator:K24:12)
		End for 
		
		ON ERR CALL:C155($vt_currentOnErrorMethod)
	End if 
	
End if   // ASSERT