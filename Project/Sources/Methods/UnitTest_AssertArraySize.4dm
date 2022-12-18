//%attributes = {"invisible":true}
// (PM) UnitTest_AssertArraySize
// Asserts whether an arrays is of a given size
// $1 = Expected size
// $2 = Pointer to array
// $3 = Failure message (optional)

C_LONGINT:C283($1; $expected)
C_POINTER:C301($2; $array)
C_TEXT:C284($3; $message)

$expected:=$1
$array:=$2

If (Count parameters:C259>=3)
	$message:=$3
Else 
	$message:="AssertArraySize Expected "+String:C10($expected)+" but got "+String:C10(Size of array:C274($array->))
End if 

UnitTest_Assert($expected=Size of array:C274($array->); $message)
