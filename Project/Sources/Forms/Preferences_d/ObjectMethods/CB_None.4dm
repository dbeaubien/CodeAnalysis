
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		Case of 
			: (Pref_GetPrefString("EXPORT - Append Date to Folder Name")="1")  // convert to new preference
				CB_None:=0
				CB_DateOnly:=0
				CB_DateTime:=1
				Pref_SetPrefString("EXPORT - Append Date to Folder Name"; "")
				Pref_SetPrefString("EXPORT - Append to Folder Name"; "Date and Time")
				
			: (Pref_GetPrefString("EXPORT - Append to Folder Name")="Date and Time")
				CB_None:=0
				CB_DateOnly:=0
				CB_DateTime:=1
				
			: (Pref_GetPrefString("EXPORT - Append to Folder Name")="Date")
				CB_None:=0
				CB_DateOnly:=1
				CB_DateTime:=0
				
			Else 
				CB_None:=1
				CB_DateOnly:=0
				CB_DateTime:=0
		End case 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		Pref_SetPrefString("EXPORT - Append to Folder Name"; "")
		
End case 