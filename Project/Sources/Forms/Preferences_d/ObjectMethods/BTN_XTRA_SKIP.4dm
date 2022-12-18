
If (at_XTRA_relativePaths{at_XTRA_relativePaths}#"") & (at_XTRA_actions{at_XTRA_relativePaths}#"Skip")
	
	at_XTRA_actions{at_XTRA_relativePaths}:="Skip"
	Pref_SetPrefTextArray("Extra Folder action"; ->at_XTRA_actions)
	
	rb_CopyFolder:=0
	rb_SkipFolder:=1
End if 