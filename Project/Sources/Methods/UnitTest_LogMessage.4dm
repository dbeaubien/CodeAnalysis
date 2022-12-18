//%attributes = {"invisible":true}
// (PM) UnitTest_LogMessage
// Log any errors/messages from the unittests

C_TEXT:C284($1; $message)

$message:=$1

UnitTest_Log:=UnitTest_Log+$message+"\r"