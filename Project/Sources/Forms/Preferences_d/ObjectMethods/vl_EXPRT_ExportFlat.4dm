Case of 
	: (Form event code:C388=On Load:K2:1)
		vl_EXPRT_ExportFlat:=Num:C11(Pref_GetPrefString("EXPRT2File DoNotNestMethods"; ""))
		
	: (Form event code:C388=On Clicked:K2:4)
		If (vl_EXPRT_ExportFlat=1)
			Pref_SetPrefString("EXPRT2File DoNotNestMethods"; "1")
		Else 
			Pref_SetPrefString("EXPRT2File DoNotNestMethods"; "")
		End if 
End case 