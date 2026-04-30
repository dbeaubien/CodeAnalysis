//%attributes = {"invisible":true}
// (PM) UnitTest_Assert
// Keeps track of passed or failed assertions and logs any errors found
// $1 = Condition
// $2 = Failure message (optional)
#DECLARE($condition : Boolean; $message : Text)


// Increment the total number of assertions
var $index : Integer
$index:=Size of array:C274(UnitTest_StatsTotal)
UnitTest_StatsTotal{$index}:=UnitTest_StatsTotal{$index}+1

// Increment the number of passed or failed assertions
If ($condition)
	UnitTest_StatsPassed{$index}:=UnitTest_StatsPassed{$index}+1
Else 
	UnitTest_StatsFailed{$index}:=UnitTest_StatsFailed{$index}+1
	UnitTest_LogMessage(UnitTest_StatsTestCase{$index}+", "+UnitTest_StatsTestName{$index}+": Failed: "+$message)
End if 
