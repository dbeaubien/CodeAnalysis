//%attributes = {"invisible":true}
// (PM) UnitTest_AssertEqualLongint
//
// Asserts whether two longints are equal
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)
//
#DECLARE($expected : Integer; $actual : Integer; $message : Text)
// ----------------------------------------------------

If (Count parameters:C259<3)
	$message:="AssertEqualLongint Expected "+String:C10($expected)+" but got "+String:C10($actual)
End if 

UnitTest_Assert($expected=$actual; $message)