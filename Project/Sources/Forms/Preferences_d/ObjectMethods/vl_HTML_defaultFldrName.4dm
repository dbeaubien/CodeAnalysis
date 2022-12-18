
Case of 
	: (Form event code:C388=On Load:K2:1)
		vl_HTML_defaultFldrName:=Pref_GetPrefString("HTML2File Default Folder Name"; "Methods as HTML")
		
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($vt_msg)
		C_BOOLEAN:C305($vb_saveValue)
		$vb_saveValue:=False:C215
		Case of 
			: (vl_HTML_defaultFldrName="")
				$vt_msg:=Get localized string:C991("Msg_MTHD_DfltFldNeeded")  // "A default folder name must be specified."
				
			: (Position:C15(Folder separator:K24:12; vl_HTML_defaultFldrName)>0)
				$vt_msg:=Replace string:C233(Get localized string:C991("Msg_MTHD_DfltFldBadChar"); "%1"; Folder separator:K24:12)  // "The default name cannot contain the folder separator \""+Folder separator +"\"."
				
			Else 
				$vb_saveValue:=True:C214
		End case 
		
		
		If ($vb_saveValue)
			Pref_SetPrefString("HTML2File Default Folder Name"; vl_HTML_defaultFldrName)
		Else 
			vl_HTML_defaultFldrName:=Pref_GetPrefString("HTML2File Default Folder Name"; "Methods as HTML")
			BEEP:C151
			ALERT:C41($vt_msg)
			GOTO OBJECT:C206(vl_HTML_defaultFldrName)
		End if 
End case 