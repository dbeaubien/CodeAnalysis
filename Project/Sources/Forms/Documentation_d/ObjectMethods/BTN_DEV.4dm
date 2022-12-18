
Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Not:C34(Is compiled mode:C492))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		Case of 
			: (tabControl=1)  // Release Notes
				SHOW ON DISK:C922(Get 4D folder:C485(Current resources folder:K5:16)+"Release Notes"+Folder separator:K24:12+"ReleaseNotes.html")
				
			: (tabControl=2)  // Component Docs
				SHOW ON DISK:C922(Get 4D folder:C485(Current resources folder:K5:16)+"4D Docs"+Folder separator:K24:12+"index.html")
				
		End case 
End case 