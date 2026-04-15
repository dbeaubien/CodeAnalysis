//%attributes = {"invisible":true}
// (PM) UnitTest_AssertNil
//
// Asserts whether a pointer is a nil pointer
//
// $1 = Pointer
// $2 = Failure message (optional)
//
#DECLARE($pointer : Pointer; $message : Text)
// ----------------------------------------------------

If (Count parameters:C259<2)
	$message:="AssertNil Expected Nil but got "+UnitTest__ResolvePointer($pointer)
End if 

UnitTest_Assert(Is nil pointer:C315($pointer); $message)
