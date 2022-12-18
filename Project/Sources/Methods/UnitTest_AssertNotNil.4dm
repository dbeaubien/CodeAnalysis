//%attributes = {"invisible":true}
// (PM) UnitTest_AssertNotNil
// Asserts whether a pointer is not a nil pointer
// $1 = Pointer
// $2 = Failure message (optional)

C_POINTER:C301($1; $pointer)
C_TEXT:C284($2; $message)

$pointer:=$1

If (Count parameters:C259>=2)
	$message:=$2
Else 
	$message:="AssertNotNil Expected Not Nil but got "+UnitTest__ResolvePointer($pointer)
End if 

UnitTest_Assert(Is nil pointer:C315($pointer)=False:C215; $message)
