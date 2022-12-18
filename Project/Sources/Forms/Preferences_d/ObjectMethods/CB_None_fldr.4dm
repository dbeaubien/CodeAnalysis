//   Mod: DB (04/11/2014) - Added

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		Case of 
			: (Pref_GetPrefString("EXTRAS - Append to Folder Name")="Date and Time")
				CB_None_fldr:=0
				CB_DateOnly_fldr:=0
				CB_DateTime_fldr:=1
				
			: (Pref_GetPrefString("EXTRAS - Append to Folder Name")="Date")
				CB_None_fldr:=0
				CB_DateOnly_fldr:=1
				CB_DateTime_fldr:=0
				
			Else 
				CB_None_fldr:=1
				CB_DateOnly_fldr:=0
				CB_DateTime_fldr:=0
		End case 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		Pref_SetPrefString("EXTRAS - Append to Folder Name"; "")
		
End case 