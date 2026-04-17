//%attributes = {"invisible":true}
// (PM) UnitTest_AssertFalse
// Asserts whether a boolean is False
// $1 = Boolean
// $2 = Failure message (optional)

#DECLARE($boolean : Boolean; $message : Text)

If ($message="")
	$message:="AssertFalse Expected False but got True"
End if 

UnitTest_Assert($boolean=False:C215; $message)
