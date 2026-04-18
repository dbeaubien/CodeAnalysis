Case of 
	: (Form event code:C388=On Load:K2:1)
		var vSearch : Text
		vSearch:=""
		
		
	: (Form event code:C388=On Data Change:K2:15)
		Explorer_ApplyMethodFilter(Form:C1466)
		
End case 
