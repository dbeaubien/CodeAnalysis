Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vSearch)
		vSearch:=""
		
		
	: (Form event code:C388=On Data Change:K2:15)
		Explorer_ApplyMethodFilter(Form:C1466)
		
End case 
