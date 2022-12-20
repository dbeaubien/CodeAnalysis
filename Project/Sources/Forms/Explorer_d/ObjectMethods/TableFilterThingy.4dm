//Searchpicker sample code

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vTableFilter)
		vTableFilter:=""  // Init the var itself
		SearchPicker SET HELP TEXT("TableFilterThingy"; "Table name@")  //<TRANSLATION>
		
		
	: (Form event code:C388=On Data Change:K2:15)
		Form:C1466.controller.FilterTableList(vTableFilter)
		
End case 
