//%attributes = {"invisible":true}
// (PM) UnitTest_AssertFolderExists
// Asserts whether a folder exists
// $1 = Foldername
// $2 = Failure message (optional)

#DECLARE($foldername : Text; $message : Text)

If ($message="")
	$message:="AssertFolderExists Expected folder \""+$foldername+"\""
End if 

UnitTest_Assert(Test path name:C476($foldername)=Is a folder:K24:2; $message)
