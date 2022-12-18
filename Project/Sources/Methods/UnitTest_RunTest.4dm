//%attributes = {"invisible":true}
// (PM) UnitTest_RunTest
// Runs a single test for the current testcase
// $1 = Test name

C_TEXT:C284($1; $testname; $testcase)
C_LONGINT:C283($index; $start; $stop)

$testname:=$1
$testcase:=UnitTest_CurrentTestCase

// Add the test to our statistics
APPEND TO ARRAY:C911(UnitTest_StatsTestCase; $testcase)
APPEND TO ARRAY:C911(UnitTest_StatsTestName; $testname)
APPEND TO ARRAY:C911(UnitTest_StatsDuration; 0)
APPEND TO ARRAY:C911(UnitTest_StatsPercentage; 0)
APPEND TO ARRAY:C911(UnitTest_StatsTotal; 0)
APPEND TO ARRAY:C911(UnitTest_StatsPassed; 0)
APPEND TO ARRAY:C911(UnitTest_StatsFailed; 0)
$index:=Size of array:C274(UnitTest_StatsDuration)

// Run the test
$start:=Milliseconds:C459
EXECUTE FORMULA:C63($testcase+"(\"Setup\")")
EXECUTE FORMULA:C63($testcase+"(\""+$testname+"\")")
EXECUTE FORMULA:C63($testcase+"(\"TearDown\")")
$stop:=Milliseconds:C459

// Store the duration of the test
UnitTest_StatsDuration{$index}:=$stop-$start
