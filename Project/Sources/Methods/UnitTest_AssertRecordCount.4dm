//%attributes = {"invisible":true}
// (PM) UnitTest_AssertRecordCount
// Asserts the number of records in selection of a table
// $1 = Expected record count
// $2 = Pointer to table
// $3 = Failure message (optional)

#DECLARE($expected : Integer; $table : Pointer; $message : Text)

If ($message="")
	$message:="AssertRecordCount Expected "+String:C10($expected)+" but got "+String:C10(Records in selection:C76($table->))
End if 

UnitTest_Assert($expected=Records in selection:C76($table->); $message)
