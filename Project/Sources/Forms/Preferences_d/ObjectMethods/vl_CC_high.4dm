
Case of 
	: (Form event code:C388=On Load:K2:1)
		vl_CC_high:=Num:C11(Pref_GetPrefString("CC High Risk"; "25"))
		
	: (Form event code:C388=On Data Change:K2:15)
		var $vt_msg : Text
		var $vb_saveValue : Boolean
		$vb_saveValue:=False:C215
		Case of 
			: (vl_CC_mid>=vl_CC_high)
				$vt_msg:=Localized string:C991("Msg_COMP_HighRisk_ToLow")
				
			Else 
				$vb_saveValue:=True:C214
		End case 
		
		
		If ($vb_saveValue)
			Pref_SetPrefString("CC High Risk"; String:C10(vl_CC_high))
		Else 
			vl_CC_high:=Num:C11(Pref_GetPrefString("CC High Risk"; "25"))
			BEEP:C151
			ALERT:C41($vt_msg)
			GOTO OBJECT:C206(vl_CC_high)
		End if 
End case 