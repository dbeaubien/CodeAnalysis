//%attributes = {"invisible":true}
// CodeAnalysis__GetDestFolder : text
//
// Description
//   Returns the root destination folder
//
#DECLARE() : Text
// ----------------------------------------------------

var $vt_default_Folder : Text

If (Application type:C494=4D Remote mode:K5:5)
	$vt_default_Folder:=File_GetFolderName(Application file:C491)
	
Else 
	// Figure out what the "default" folder is
	$vt_default_Folder:=File_GetFolderName(Structure file:C489(*))
	If (File_GetFileName(Structure file:C489(*))=File_GetFileName(Structure file:C489))  // Are we in a 4dbase folder?
		$vt_default_Folder:=File_GetFolderName($vt_default_Folder)
	End if 
End if 

$vt_default_Folder+="Code Analysis Folder"+Folder separator:K24:12

// Now try to get it from the preferences
$vt_default_Folder:=Pref_GetPrefString("destinationFolder v2"; $vt_default_Folder)  // Change pref name, force a reset

return $vt_default_Folder
