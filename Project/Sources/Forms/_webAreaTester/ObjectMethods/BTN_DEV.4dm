
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		var vt_lastDocument : Text
		If (vt_lastDocument="")
			vt_lastDocument:=File_GetFolderName(Structure file:C489)
		End if 
		
		var $vt_file : Text
		$vt_file:=Select document:C905(vt_lastDocument; ""; "Select HTML"; Use sheet window:K24:11)
		
		If (OK=1)
			vt_lastDocument:=File_GetFolderName(Document)
			WA OPEN URL:C1020(myWebArea; Document)
		End if 
		
End case 