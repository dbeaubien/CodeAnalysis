//%attributes = {"invisible":true}
// (PM) UnitTest_AssertNotNil
// Asserts whether a pointer is not a nil pointer
// $1 = Pointer
// $2 = Failure message (optional)

#DECLARE($pointer : Pointer; $message : Text)

If (Count parameters:C259#2)
	$message:="AssertNotNil Expected Not Nil but got "+UnitTest__ResolvePointer($pointer)
End if 

UnitTest_Assert(Is nil pointer:C315($pointer)=False:C215; $message)
