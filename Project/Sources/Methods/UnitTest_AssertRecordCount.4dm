//%attributes = {"invisible":true}
// (PM) UnitTest_AssertRecordCount
// Asserts the number of records in selection of a table
// $1 = Expected record count
// $2 = Pointer to table
// $3 = Failure message (optional)

C_LONGINT:C283($1; $expected)
C_POINTER:C301($2; $table)
C_TEXT:C284($3; $message)

$expected:=$1
$table:=$2

If (Count parameters:C259>=3)
	$message:=$3
Else 
	$message:="AssertRecordCount Expected "+String:C10($expected)+" but got "+String:C10(Records in selection:C76($table->))
End if 

UnitTest_Assert($expected=Records in selection:C76($table->); $message)
