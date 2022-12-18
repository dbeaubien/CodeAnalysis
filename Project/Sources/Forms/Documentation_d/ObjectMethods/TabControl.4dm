Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222($at_urls; 0)
		ARRAY BOOLEAN:C223($ab_doAllow; 0)
		
		// First disallow all 
		//APPEND TO ARRAY($at_urls;"*")  // all 
		//APPEND TO ARRAY($ab_doAllow;False)  // forbidden 
		//
		//  // Then allow the given urls if any 
		//APPEND TO ARRAY($at_urls;Get 4D folder(Current Resources folder)+"Release Notes"+Folder separator+"ReleaseNotes.html")  //url 
		//APPEND TO ARRAY($ab_doAllow;True)  //allowed 
		//
		//APPEND TO ARRAY($at_urls;Get 4D folder(Current Resources folder)+"4D Docs"+Folder separator+"index.html")  //url 
		//APPEND TO ARRAY($ab_doAllow;True)  //allowed 
		
		//Install the filter 
		//WA SET URL FILTERS(myWebArea;$at_urls;$ab_doAllow)
		
		
		//ARRAY TEXT(tabControl;2)
		//TabControl{1}:="Release Notes"
		//TabControl{2}:="Component API Docs"
		//  //If (Not(Is compiled mode))  //   Mod: DB (05/11/2015) - Place for playing with HTML
		//  //APPEND TO ARRAY(tabControl;"PLAY")
		//  //End if 
		
		//C_LONGINT(<>_CODEANALYSIS_DOC_DEFAULTTABNO)
		//If (<>_CODEANALYSIS_DOC_DEFAULTTABNO=0)
		//<>_CODEANALYSIS_DOC_DEFAULTTABNO:=1
		//End if 
		
		//tabControl:=<>_CODEANALYSIS_DOC_DEFAULTTABNO  // Default
		//If (TabControl#1)
		//FORM GOTO PAGE(TabControl)
		//End if 
		//<>_CODEANALYSIS_DOC_DEFAULTTABNO:=0  // RESET IT FOR NEXT TIME
		
	: (Form event code:C388=On Clicked:K2:4)
		FORM GOTO PAGE:C247(TabControl)
		Component_DocDialog_SetTab(TabControl)
End case 

