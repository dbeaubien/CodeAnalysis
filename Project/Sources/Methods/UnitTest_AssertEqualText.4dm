//%attributes = {"invisible":true}
// (PM) UnitTest_AssertEqualText
// Asserts whether two texts are equal
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)

var $1; $expected : Text
var $2; $actual : Text
var $3; $message : Text

$expected:=$1
$actual:=$2

If (Count parameters:C259>=3)
	$message:=$3
Else 
	$message:="AssertEqualText Expected \""+$expected+"\" but got \""+$actual+"\""
End if 

UnitTest_Assert($expected=$actual; $message)
