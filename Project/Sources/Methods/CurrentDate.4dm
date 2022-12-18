//%attributes = {"invisible":true}
// Project method:  CurrentDate
// By:  Guy Algot, 3/7/2003 1:20 PM
// Org: Dani Beaubien, 3/7/2003 1:20 PM
// File/Layout:  
// Description:  returns the current date

C_DATE:C307($0)
C_DATE:C307(<>gDate)  // this is the var that is currently used here

Case of 
	: (<>gDate=!00-00-00!)  // first time called
		<>gDate:=Current date:C33(*)
		
	: (Application type:C494=4D Remote mode:K5:5)
		If (<>gDate#Current date:C33)  // check for a local difference
			<>gDate:=Current date:C33(*)
		End if 
		
	Else   // running as a server or standalone, get the date directly
		<>gDate:=Current date:C33
End case 

$0:=<>gDate

