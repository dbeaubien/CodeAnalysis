//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): Dani Beaubien
// Date and time: 09/19/12, 20:47:08
// ----------------------------------------------------
// Method: CodeAnalysis__GetDestFolder
// Description
//   Returns the root destination folder
//
C_TEXT:C284($0)
// ----------------------------------------------------
//   Mod by: Dani Beaubien (10/31/2012) - Handle if a 4D Client
//   Mod by: Dani Beaubien (10/31/2012) - Change pref name, force a reset
// ----------------------------------------------------

C_TEXT:C284($vt_default_Folder)

If (Application type:C494=4D Remote mode:K5:5)
	$vt_default_Folder:=File_GetFolderName(Application file:C491)  //   Mod by: Dani Beaubien (10/31/2012)
	
Else 
	// Figure out what the "default" folder is
	$vt_default_Folder:=File_GetFolderName(Structure file:C489(*))
	If (File_GetFileName(Structure file:C489(*))=File_GetFileName(Structure file:C489))  // Are we in a 4dbase folder?
		$vt_default_Folder:=File_GetFolderName($vt_default_Folder)
	End if 
End if 

$vt_default_Folder:=$vt_default_Folder+"Code Analysis Folder"+Folder separator:K24:12



// Now try to get it from the preferences
$vt_default_Folder:=Pref_GetPrefString("destinationFolder v2"; $vt_default_Folder)  //   Mod by: Dani Beaubien (10/31/2012) - Change pref name, force a reset


$0:=$vt_default_Folder
