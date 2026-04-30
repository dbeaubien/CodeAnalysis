//%attributes = {"invisible":true}
// (PM) UnitTest_SaveLog
// Saves the log of the unit test to a disk file
// $1 = Filename
#DECLARE($filename : Text)

var $doc : Time
$doc:=Create document:C266($filename)
If (OK=1)
	SEND PACKET:C103($doc; UnitTest_Log)
	CLOSE DOCUMENT:C267($doc)
End if 
