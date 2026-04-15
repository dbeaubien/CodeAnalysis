//%attributes = {"invisible":true}
// (PM) UnitTest_LogMessage
// Log any errors/messages from the unittests

var $1; $message : Text

$message:=$1

UnitTest_Log:=UnitTest_Log+$message+"\r"