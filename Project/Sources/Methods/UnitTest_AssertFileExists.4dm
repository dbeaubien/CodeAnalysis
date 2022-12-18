//%attributes = {"invisible":true}
// (PM) UnitTest_AssertFileExists
// Asserts whether a file exists
// $1 = Filename
// $2 = Failure message (optional)

C_TEXT:C284($1; $filename)
C_TEXT:C284($2; $message)

$filename:=$1

If (Count parameters:C259>=2)
	$message:=$2
Else 
	$message:="AssertFileExists Expected file \""+$filename+"\""
End if 

UnitTest_Assert(Test path name:C476($filename)=Is a document:K24:1; $message)
