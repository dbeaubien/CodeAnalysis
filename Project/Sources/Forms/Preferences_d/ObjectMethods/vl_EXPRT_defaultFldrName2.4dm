
Case of 
	: (Form event code:C388=On Load:K2:1)
		vl_EXPRT_defaultFldrName2:=Pref_GetPrefString("EXPRT2File Default Form Folder Name"; "Form Property Export")
		
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($vt_msg)
		C_BOOLEAN:C305($vb_saveValue)
		$vb_saveValue:=False:C215
		Case of 
			: (vl_EXPRT_defaultFldrName2="")
				$vt_msg:=Get localized string:C991("Msg_STRCT_DfltFldNeeded")
				
			: (Position:C15(Folder separator:K24:12; vl_EXPRT_defaultFldrName2)>0)
				$vt_msg:=Replace string:C233(Get localized string:C991("Msg_STRCT_DfltFldBadChar"); "%1"; Folder separator:K24:12)
				
			Else 
				$vb_saveValue:=True:C214
		End case 
		
		
		If ($vb_saveValue)
			Pref_SetPrefString("EXPRT2File Default Form Folder Name"; vl_EXPRT_defaultFldrName2)
		Else 
			vl_EXPRT_defaultFldrName2:=Pref_GetPrefString("EXPRT2File Default Form Folder Name"; "Form Property Export")
			BEEP:C151
			ALERT:C41($vt_msg)
			GOTO OBJECT:C206(vl_EXPRT_defaultFldrName2)
		End if 
End case 