//%attributes = {"invisible":true}
// (PM) UnitTest_AssertEqualTime
// Asserts whether two times are equal
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)

C_TIME:C306($1; $expected)
C_TIME:C306($2; $actual)
C_TEXT:C284($3; $message)

$expected:=$1
$actual:=$2

If (Count parameters:C259>=3)
	$message:=$3
Else 
	$message:="AssertEqualTime Expected "+String:C10($expected; HH MM SS:K7:1)+" but got "+String:C10($actual; HH MM SS:K7:1)
End if 

UnitTest_Assert($expected=$actual; $message)
