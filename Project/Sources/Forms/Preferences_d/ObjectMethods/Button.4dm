
C_TEXT:C284($vt_newFolderPath; vt_defaultFolder)
$vt_newFolderPath:=Select folder:C670(Get localized string:C991("Msg_SelectFolder"); vt_defaultFolder)
If (OK=1)
	vt_defaultFolder:=$vt_newFolderPath
	CA_Pref_SetExportFolder(vt_defaultFolder)
End if 