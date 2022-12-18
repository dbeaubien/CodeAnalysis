//%attributes = {"invisible":true}
// Component_DocDialog_SetTab (tab) 
// Component_DocDialog_SetTab (longint) 
// 
// DESCRIPTION
//   
//
C_LONGINT:C283($1)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (02/25/2017)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	Case of 
		: ($1=1)  // Release Notes
			WA OPEN URL:C1020(myWebArea; Get 4D folder:C485(Current resources folder:K5:16)+"Release Notes"+Folder separator:K24:12+"ReleaseNotes.html")
			
		: ($1=2)  // Component Docs
			WA OPEN URL:C1020(myWebArea; Get 4D folder:C485(Current resources folder:K5:16)+"4D Docs"+Folder separator:K24:12+"index.html")
			
			//: (tabControl=3)  // Component Docs
			//WA OPEN URL(myWebArea;Get 4D folder(Current Resources folder)+"Graphs"+Folder separator +"analysis.html")
	End case 
End if   // ASSERT

