
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Pref_GetGlobalPrefString("QuickLauncher.IsFloating"; "Yes")="Yes")
			Self:C308->:=1
		Else 
			Self:C308->:=0
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Self:C308->=1)
			Pref_SetGlobalPrefString("QuickLauncher.IsFloating"; "Yes")
		Else 
			Pref_SetGlobalPrefString("QuickLauncher.IsFloating"; "No")
		End if 
End case 