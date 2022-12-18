//%attributes = {"invisible":true}
// (PM) UnitTest_AssertEqualPointer
// Asserts whether two pointers point to the same thing
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)

C_POINTER:C301($1; $expected)
C_POINTER:C301($2; $actual)
C_TEXT:C284($3; $message)

$expected:=$1
$actual:=$2

If (Count parameters:C259>=3)
	$message:=$3
Else 
	$message:="AssertEqualPointer Expected "+UnitTest__ResolvePointer($expected)+" but got "+UnitTest__ResolvePointer($actual)
End if 

UnitTest_Assert($expected=$actual; $message)
