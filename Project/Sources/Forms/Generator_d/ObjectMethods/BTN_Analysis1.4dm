
C_TEXT:C284($vt_newFolderPath)
$vt_newFolderPath:=Select folder:C670("Select the folder to scan:"; CodeAnalysis__GetDestFolder)
If (OK=1)
	Pref_SetPrefString("DIFF.LastFolder"; $vt_newFolderPath)
	Pref_SetPrefString("DIFF.LastFolder_NameOnly"; File_GetFileName($vt_newFolderPath))
	
	<>_DIFF_PathToFileOnDisk:=$vt_newFolderPath
	vt_lastDIFFCheck_Folder:=$vt_newFolderPath  // Mod by: Dani Beaubien (6/27/13) - Capture this
	vt_lastDIFFCheck_FolderNameOnly:="DIFF Fldr: "+Pref_GetPrefString("DIFF.LastFolder_NameOnly")
	
	Form:C1466.methodsWithDifference:=New collection:C1472
	CODE_doDiffOnFolder(Form:C1466.methodsWithDifference)
End if 