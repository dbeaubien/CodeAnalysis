// (FM) [Dialogs];"UnitTest_Dialog"

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		Component_SetMenuBar
		UnitTest_Init("all_soft")  // only init if it has not happened yet
		
	: (Form event code:C388=On Activate:K2:9)
		Component_SetMenuBar
		
	: (Form event code:C388=On Unload:K2:2)
		UnitTest_Init("all")
		
End case 