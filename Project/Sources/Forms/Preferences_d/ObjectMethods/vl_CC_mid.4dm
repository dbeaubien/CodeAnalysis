
Case of 
	: (Form event code:C388=On Load:K2:1)
		vl_CC_mid:=Num:C11(Pref_GetPrefString("CC Med Risk"; "11"))
		
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($vt_msg)
		C_BOOLEAN:C305($vb_saveValue)
		$vb_saveValue:=False:C215
		Case of 
			: (vl_CC_mid<2)
				$vt_msg:=Get localized string:C991("Msg_COMP_MedRisk_ToLow")
				
			: (vl_CC_mid>=vl_CC_high)
				$vt_msg:=Get localized string:C991("Msg_COMP_MedRisk_ToHigh")
				
			Else 
				$vb_saveValue:=True:C214
		End case 
		
		
		If ($vb_saveValue)
			Pref_SetPrefString("CC Med Risk"; String:C10(vl_CC_mid))
		Else 
			vl_CC_mid:=Num:C11(Pref_GetPrefString("CC Med Risk"; "11"))
			BEEP:C151
			ALERT:C41($vt_msg)
			GOTO OBJECT:C206(vl_CC_mid)
		End if 
End case 