
If (Form event code:C388=On Load:K2:1)
	C_TEXT:C284(vt_lastDIFFCheck_Folder)
	
	// Task 2176
	vt_lastDIFFCheck_FolderNameOnly:="DIFF Fldr: "+Pref_GetPrefString("DIFF.LastFolder_NameOnly")
	vt_lastDIFFCheck_Folder:=Pref_GetPrefString("DIFF.LastFolder")
	If (Not:C34(Folder_DoesExist(vt_lastDIFFCheck_Folder)))
		vt_lastDIFFCheck_Folder:=""
		vt_lastDIFFCheck_FolderNameOnly:=""
		OBJECT SET ENABLED:C1123(BTN_Analysis_Recheck; False:C215)
	End if 
End if 

If (Form event code:C388=On Clicked:K2:4)
	Form:C1466.refreshDiff:=True:C214
End if 