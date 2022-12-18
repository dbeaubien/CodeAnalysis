
Case of 
	: (Form event code:C388=On Load:K2:1)
		Component_SetMenuBar
		
		ARRAY TEXT:C222(tabControl; 2)
		TabControl{1}:="Release Notes"
		TabControl{2}:="Component API Docs"
		//If (Not(Is compiled mode))  //   Mod: DB (05/11/2015) - Place for playing with HTML
		//APPEND TO ARRAY(tabControl;"PLAY")
		//End if 
		
	: (Form event code:C388=On Activate:K2:9)
		Component_SetMenuBar
End case 


If (Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11)
	C_LONGINT:C283(<>_CODEANALYSIS_DOC_DEFAULTTABNO)
	If (<>_CODEANALYSIS_DOC_DEFAULTTABNO=0)
		<>_CODEANALYSIS_DOC_DEFAULTTABNO:=1
	End if 
	
	tabControl:=<>_CODEANALYSIS_DOC_DEFAULTTABNO  // Default
	If (TabControl#1)
		FORM GOTO PAGE:C247(TabControl)
	End if 
	<>_CODEANALYSIS_DOC_DEFAULTTABNO:=1  // RESET IT FOR NEXT TIME
	
	Component_DocDialog_SetTab(TabControl)
End if 


