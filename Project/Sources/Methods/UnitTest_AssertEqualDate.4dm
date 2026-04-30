//%attributes = {"invisible":true}
// (PM) UnitTest_AssertEqualDate
// Asserts whether two dates are equal
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)
#DECLARE($expected : Date; $actual : Date; $message : Text)
// ----------------------------------------------------

If (Count parameters:C259<3)
	$message:="AssertEqualDate Expected "+String:C10($expected; Internal date short:K1:7)+" but got "+String:C10($actual; Internal date short:K1:7)
End if 

UnitTest_Assert($expected=$actual; $message)
