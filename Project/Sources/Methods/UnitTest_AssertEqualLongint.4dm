//%attributes = {"invisible":true}
// (PM) UnitTest_AssertEqualLongint
// Asserts whether two longints are equal
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)

C_LONGINT:C283($1; $expected)
C_LONGINT:C283($2; $actual)
C_TEXT:C284($3; $message)

$expected:=$1
$actual:=$2

If (Count parameters:C259>=3)
	$message:=$3
Else 
	$message:="AssertEqualLongint Expected "+String:C10($expected)+" but got "+String:C10($actual)
End if 

UnitTest_Assert($expected=$actual; $message)
