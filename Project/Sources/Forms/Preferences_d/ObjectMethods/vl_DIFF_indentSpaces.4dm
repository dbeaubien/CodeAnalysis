
Case of 
	: (Form event code:C388=On Load:K2:1)
		vl_DIFF_indentSpaces:=Num:C11(Pref_GetPrefString("DIFF indentSpaces"; "2"))
		
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($vt_msg)
		C_BOOLEAN:C305($vb_saveValue)
		$vb_saveValue:=False:C215
		Case of 
			: (vl_DIFF_indentSpaces<1)
				$vt_msg:=Get localized string:C991("Msg_MTHD_MinIndent")  // "The minimum indent must be 1 or higher."
				
			: (vl_DIFF_indentSpaces>10)
				$vt_msg:=Get localized string:C991("Msg_MTHD_MaxIndent")  // "The maximum indent must be 10 or less."
				
			Else 
				$vb_saveValue:=True:C214
		End case 
		
		
		If ($vb_saveValue)
			Pref_SetPrefString("DIFF indentSpaces"; String:C10(vl_DIFF_indentSpaces))
		Else 
			vl_DIFF_indentSpaces:=Num:C11(Pref_GetPrefString("DIFF indentSpaces"; "2"))
			BEEP:C151
			ALERT:C41($vt_msg)
			GOTO OBJECT:C206(vl_DIFF_indentSpaces)
		End if 
End case 