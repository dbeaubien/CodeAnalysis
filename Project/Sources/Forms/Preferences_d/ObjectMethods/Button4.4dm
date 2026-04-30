
var $vt_pathToUserDictionary : Text
$vt_pathToUserDictionary:=Spell_GetPathToUserDictationary
If (Not:C34(File_DoesExist($vt_pathToUserDictionary)))
	BEEP:C151
	ALERT:C41(Localized string:C991("Msg_COMP_UserDictAlert"))
Else 
	SHOW ON DISK:C922($vt_pathToUserDictionary)
End if 
