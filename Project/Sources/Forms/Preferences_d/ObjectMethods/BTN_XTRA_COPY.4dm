
If (at_XTRA_relativePaths{at_XTRA_relativePaths}#"") & (at_XTRA_actions{at_XTRA_relativePaths}#"Copy")
	
	at_XTRA_actions{at_XTRA_relativePaths}:="Copy"
	Pref_SetPrefTextArray("Extra Folder action"; ->at_XTRA_actions)
	
	rb_CopyFolder:=1
	rb_SkipFolder:=0
End if 