//%attributes = {"invisible":true}
// (PM) UnitTest_AssertEqualText
// Asserts whether two texts are equal
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)

#DECLARE($expected : Text; $actual : Text; $message : Text)

If (Count parameters:C259#3)
	$message:="AssertEqualText Expected \""+$expected+"\" but got \""+$actual+"\""
End if 

UnitTest_Assert($expected=$actual; $message)
