//   Mod: DB (08/29/2015)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		Case of 
			: (Pref_GetPrefString("EXPORT - Append Date to Form Folder Name")="1")  // convert to new preference
				CB_None_form:=0
				CB_DateOnly_form:=0
				CB_DateTime_form:=1
				Pref_SetPrefString("EXPORT - Append Date to Form Folder Name"; "")  // clear this
				Pref_SetPrefString("EXPORT - Append to Form Folder Name"; "Date and Time")
				
			: (Pref_GetPrefString("EXPORT - Append to Form Folder Name")="Date and Time")
				CB_None_form:=0
				CB_DateOnly_form:=0
				CB_DateTime_form:=1
				
			: (Pref_GetPrefString("EXPORT - Append to Form Folder Name")="Date")
				CB_None_form:=0
				CB_DateOnly_form:=1
				CB_DateTime_form:=0
				
			Else 
				CB_None_form:=1
				CB_DateOnly_form:=0
				CB_DateTime_form:=0
		End case 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		Pref_SetPrefString("EXPORT - Append to Form Folder Name"; "")
		
End case 