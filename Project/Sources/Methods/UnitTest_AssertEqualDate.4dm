//%attributes = {"invisible":true}
// (PM) UnitTest_AssertEqualDate
// Asserts whether two dates are equal
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)

C_DATE:C307($1; $expected)
C_DATE:C307($2; $actual)
C_TEXT:C284($3; $message)

$expected:=$1
$actual:=$2

If (Count parameters:C259>=3)
	$message:=$3
Else 
	$message:="AssertEqualDate Expected "+String:C10($expected; Internal date short:K1:7)+" but got "+String:C10($actual; Internal date short:K1:7)
End if 

UnitTest_Assert($expected=$actual; $message)
