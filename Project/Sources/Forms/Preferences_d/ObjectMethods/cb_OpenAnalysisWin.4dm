
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Pref_GetGlobalPrefString("OnStartup.OpenMainWindow"; "No")="Yes")
			Self:C308->:=1
		Else 
			Self:C308->:=0
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Self:C308->=1)
			Pref_SetGlobalPrefString("OnStartup.OpenMainWindow"; "Yes")
		Else 
			Pref_SetGlobalPrefString("OnStartup.OpenMainWindow"; "No")
		End if 
End case 