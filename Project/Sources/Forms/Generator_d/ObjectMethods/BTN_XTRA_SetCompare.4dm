
C_TEXT:C284($vt_newFolderPath)
$vt_newFolderPath:=Select folder:C670("Compare with folder"; CodeAnalysis__GetDestFolder)
If (OK=1)
	If ($vt_newFolderPath=("@"+Folder separator:K24:12))
		$vt_newFolderPath:=Substring:C12($vt_newFolderPath; 1; Length:C16($vt_newFolderPath)-1)
	End if 
	at_XTRA_comparePathsFULL{at_XTRA_comparePathsFULL}:=$vt_newFolderPath
	Pref_SetPrefTextArray("Extra Folder CompareTo"; ->at_XTRA_comparePathsFULL)
	vt_fullPath:="Compare to --> "+$vt_newFolderPath
	
	at_XTRA_compareFolderName{at_XTRA_comparePathsFULL}:=File_GetFileName(at_XTRA_comparePathsFULL{at_XTRA_comparePathsFULL})+Folder separator:K24:12
End if 


