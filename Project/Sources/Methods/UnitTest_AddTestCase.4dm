//%attributes = {"invisible":true}
// (PM) UnitTest_AddTestCase
// Adds a testcase to the unit tests
// $1 = Test case (=project method)

C_TEXT:C284($1; $testcase)

$testcase:=$1

If (Find in array:C230(UnitTest_TestCases; $testcase)<1)
	APPEND TO ARRAY:C911(UnitTest_TestCaseEnabled; True:C214)
	APPEND TO ARRAY:C911(UnitTest_TestCases; $testcase)
End if 
