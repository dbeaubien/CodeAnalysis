//%attributes = {"invisible":true}
// (PM) UnitTest_AssertTrue
// Asserts whether a boolean is True
// $1 = Boolean
// $2 = Failure message (optional)

C_BOOLEAN:C305($1; $boolean)
C_TEXT:C284($2; $message)

$boolean:=$1

If (Count parameters:C259>=2)
	$message:=$2
Else 
	$message:="AssertTrue Expected True but got False"
End if 

UnitTest_Assert($boolean; $message)
