
C_BOOLEAN:C305(<>LOG_IsInDebugMode)

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Pref_GetGlobalPrefString("IsInLoggingMode"; "No")="Yes")
			CB_isInDebugMode:=1
		Else 
			CB_isInDebugMode:=0
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		If (CB_isInDebugMode=1)
			Pref_SetGlobalPrefString("IsInLoggingMode"; "Yes")
		Else 
			Pref_SetGlobalPrefString("IsInLoggingMode"; "No")
		End if 
End case 

<>LOG_IsInDebugMode:=(CB_isInDebugMode=1)
