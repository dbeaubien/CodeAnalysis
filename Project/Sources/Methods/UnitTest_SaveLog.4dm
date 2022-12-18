//%attributes = {"invisible":true}
// (PM) UnitTest_SaveLog
// Saves the log of the unit test to a disk file
// $1 = Filename

C_TEXT:C284($1; $filename)
C_TIME:C306($doc)

$filename:=$1

$doc:=Create document:C266($filename)
If (OK=1)
	SEND PACKET:C103($doc; UnitTest_Log)
	CLOSE DOCUMENT:C267($doc)
End if 
