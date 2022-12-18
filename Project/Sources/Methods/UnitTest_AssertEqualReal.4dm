//%attributes = {"invisible":true}
// (PM) UnitTest_AssertEqualReal
// Asserts whether two reals are equal
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)

C_REAL:C285($1; $expected)
C_REAL:C285($2; $actual)
C_TEXT:C284($3; $message)

$expected:=$1
$actual:=$2

If (Count parameters:C259>=3)
	$message:=$3
Else 
	$message:="AssertEqualReal Expected "+String:C10($expected)+" but got "+String:C10($actual)
End if 

UnitTest_Assert($expected=$actual; $message)
