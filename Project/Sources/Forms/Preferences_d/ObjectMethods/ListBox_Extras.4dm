//   Mod: DB (03/28/2014) - Use generic method for loading methods

C_BOOLEAN:C305($vb_doDoubleClick)
$vb_doDoubleClick:=False:C215

Case of 
	: (Form event code:C388=On Load:K2:1)
		// ALL SETUP CODE IS IN THE FORM METHOD ON THE ON ACTIVATE FORM EVENT
		
	: (Form event code:C388=On Double Clicked:K2:5)
		// NOP
		
		
	: (Form event code:C388=On Clicked:K2:4) & (at_XTRA_relativePaths=0)
		OBJECT SET ENABLED:C1123(*; "BTN_XTRA_@"; False:C215)
		vt_fullPath:=""
		rb_CopyFolder:=0
		rb_SkipFolder:=0
		
	: (Form event code:C388=On Clicked:K2:4) & (at_XTRA_relativePaths>0)
		OBJECT SET ENABLED:C1123(*; "BTN_XTRA_@"; True:C214)
		vt_fullPath:=Folder_GetPathFrmRelativeToStct(at_XTRA_relativePaths{at_XTRA_relativePaths})
		If (at_XTRA_actions{at_XTRA_relativePaths}="Copy")
			rb_CopyFolder:=1
			rb_SkipFolder:=0
		Else 
			rb_CopyFolder:=0
			rb_SkipFolder:=1
		End if 
		
End case 
