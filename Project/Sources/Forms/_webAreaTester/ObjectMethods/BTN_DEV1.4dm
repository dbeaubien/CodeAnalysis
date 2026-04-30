
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		var $vt_file : Text
		$vt_file:=Select document:C905(File_GetFolderName(Structure file:C489); ""; "Select HTML"; Use sheet window:K24:11)
		
		If (OK=1)
			var vt_lastDocument : Text
			vt_lastDocument:=File_GetFolderName(Document)
			WA OPEN URL:C1020(myWebArea; Document)
		End if 
		
End case 