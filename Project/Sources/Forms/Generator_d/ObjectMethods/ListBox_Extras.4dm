//   Mod: DB (03/28/2014) - Use generic method for loading methods

C_BOOLEAN:C305($vb_doDoubleClick)
$vb_doDoubleClick:=False:C215

Case of 
	: (Form event code:C388=On Load:K2:1)
		// ALL THIS IN THE FORM METHOD'S ON ACTIVATE FORM EVENT
		
	: (Form event code:C388=On Double Clicked:K2:5)
		// NOP
		
		
	: (Form event code:C388=On Clicked:K2:4) & (at_XTRA_relativePaths=0)
		OBJECT SET ENABLED:C1123(*; "BTN_XTRA_@"; False:C215)
		vt_fullPath:=""
		
	: (Form event code:C388=On Clicked:K2:4) & (at_XTRA_relativePaths>0)
		If (at_XTRA_actions{at_XTRA_relativePaths}="Skip")
			OBJECT SET ENABLED:C1123(*; "BTN_XTRA_@"; False:C215)
			vt_fullPath:=""
			
		Else 
			OBJECT SET ENABLED:C1123(*; "BTN_XTRA_@"; True:C214)
			If (at_XTRA_comparePathsFULL{at_XTRA_relativePaths}#"")
				vt_fullPath:="Compare to --> "+at_XTRA_comparePathsFULL{at_XTRA_relativePaths}
			Else 
				vt_fullPath:=""
			End if 
		End if 
		
End case 
