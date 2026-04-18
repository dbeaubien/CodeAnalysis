//%attributes = {"invisible":true}
// (PM) UnitTest_AssertEqualReal
// Asserts whether two reals are equal
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)

#DECLARE($expected : Real; $actual : Real; $message : Text)

If ($message="")
	$message:="AssertEqualReal Expected "+String:C10($expected)+" but got "+String:C10($actual)
End if 

UnitTest_Assert($expected=$actual; $message)
