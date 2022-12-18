//%attributes = {"invisible":true}
// (PM) UnitTest_AssertFolderExists
// Asserts whether a folder exists
// $1 = Foldername
// $2 = Failure message (optional)

C_TEXT:C284($1; $foldername)
C_TEXT:C284($2; $message)

$foldername:=$1

If (Count parameters:C259>=2)
	$message:=$2
Else 
	$message:="AssertFolderExists Expected folder \""+$foldername+"\""
End if 

UnitTest_Assert(Test path name:C476($foldername)=Is a folder:K24:2; $message)
