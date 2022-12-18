
BEEP:C151
CONFIRM:C162(Get localized string:C991("Msg_COMP_ResetConfirm"); Get localized string:C991("Btn_Reset"); Get localized string:C991("Btn_Cancel"))
If (OK=1)
	vl_CC_mid:=11
	Pref_SetPrefString("CC Med Risk"; String:C10(vl_CC_mid))
	
	vl_CC_high:=25
	Pref_SetPrefString("CC High Risk"; String:C10(vl_CC_high))
End if 