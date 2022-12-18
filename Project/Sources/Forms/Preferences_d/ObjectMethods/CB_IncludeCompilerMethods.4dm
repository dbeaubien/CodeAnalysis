
Case of 
	: (Form event code:C388=On Load:K2:1)
		CB_IncludeCompilerMethods:=Num:C11(Pref_GetPrefString("CA include Compiler Methods"; "1"))
		
		
	: (Form event code:C388=On Clicked:K2:4)
		Pref_SetPrefString("CA include Compiler Methods"; String:C10(CB_IncludeCompilerMethods))
End case 