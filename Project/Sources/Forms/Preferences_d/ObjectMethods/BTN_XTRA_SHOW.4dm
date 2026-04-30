
If (at_XTRA_relativePaths{at_XTRA_relativePaths}#"")
	
	var $vt_fullPath : Text
	$vt_fullPath:=Folder_GetPathFrmRelativeToStct(at_XTRA_relativePaths{at_XTRA_relativePaths})
	
	If (Folder_DoesExist($vt_fullPath))
		SHOW ON DISK:C922($vt_fullPath)
	Else 
		BEEP:C151
		ALERT:C41(Replace string:C233(Localized string:C991("MSg_FLDR_DoesNotExist"); "%1"; at_XTRA_relativePaths{at_XTRA_relativePaths}))
	End if 
End if 

