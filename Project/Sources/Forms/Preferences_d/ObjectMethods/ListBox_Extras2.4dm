//   Mod: DB (03/28/2014) - Use generic method for loading methods

Case of 
	: (Form event code:C388=On Load:K2:1)
		// ALL SETUP CODE IS IN THE FORM METHOD ON THE ON ACTIVATE FORM EVENT
		
	: (Form event code:C388=On Double Clicked:K2:5)
		// NOP
		
	: (Form event code:C388=On Clicked:K2:4) & (at_XTRA_ignoreNames=0)
		OBJECT SET ENABLED:C1123(*; "BTN_XTRA2_@"; False:C215)
		
	: (Form event code:C388=On Clicked:K2:4) & (at_XTRA_ignoreNames>0)
		OBJECT SET ENABLED:C1123(*; "BTN_XTRA2_@"; True:C214)
		
End case 
