//   Mod: DB (03/29/2014) - Added button

If (Form event code:C388=On Clicked:K2:4)
	BEEP:C151
	CONFIRM:C162("\""+_DIFF_MethodName+"\" will be updated with the text from the external file.\r\rPlease confirm you to load the code from the file."; "Load Code"; "Cancel")
	If (OK=1)
		Method_LoadFromFile(_DIFF_MethodName; _DIFF_PathToFileOnDisk)
		BTN_Rescan:=1
	End if 
End if 