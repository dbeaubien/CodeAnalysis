
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		var $vt_default_Folder : Text
		$vt_default_Folder:=CodeAnalysis__GetDestFolder
		
		Folder_VerifyExistance($vt_default_Folder)
		SHOW ON DISK:C922($vt_default_Folder)
End case 