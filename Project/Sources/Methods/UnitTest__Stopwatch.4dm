//%attributes = {"invisible":true}
//(PM) UnitTest__Stopwatch
// Controls the stopwatch functions for the unit tests
// $1 = Action

C_TEXT:C284($1; $action)
C_LONGINT:C283($totalDuration; $index)

$action:=$1

Case of 
		
	: ($action="start")
		UnitTest_LogMessage("Start: "+String:C10(Current date:C33; Internal date short:K1:7)+" "+String:C10(Current time:C178; HH MM SS:K7:1))
		UnitTest_LogMessage("-"*40)
		UnitTest_StartTime:=Milliseconds:C459
		
	: ($action="stop")
		UnitTest_TotalDuration:=Round:C94(Milliseconds:C459-UnitTest_StartTime/1000; 3)
		UnitTest_TotalTests:=0
		UnitTest_TotalPassed:=0
		UnitTest_TotalFailed:=0
		
		// Count the totals
		For ($index; 1; Size of array:C274(UnitTest_StatsTestCase))
			$totalDuration:=$totalDuration+UnitTest_StatsDuration{$index}
			UnitTest_TotalTests:=UnitTest_TotalTests+UnitTest_StatsTotal{$index}
			UnitTest_TotalPassed:=UnitTest_TotalPassed+UnitTest_StatsPassed{$index}
			UnitTest_TotalFailed:=UnitTest_TotalFailed+UnitTest_StatsFailed{$index}
		End for 
		
		// Count the relative duration (excluding the overhead of the unittests framework)
		For ($index; 1; Size of array:C274(UnitTest_StatsTestCase))
			UnitTest_StatsPercentage{$index}:=Round:C94((UnitTest_StatsDuration{$index}/$totalDuration)*100; 3)
		End for 
		
		// Print a summary
		UnitTest_LogMessage("-"*40)
		UnitTest_LogMessage("Stop: "+String:C10(Current date:C33; Internal date short:K1:7)+" "+String:C10(Current time:C178; HH MM SS:K7:1))
		UnitTest_LogMessage("")
		
		UnitTest_LogMessage("Duration: "+String:C10(UnitTest_TotalDuration)+" seconds")
		UnitTest_LogMessage("Total tests: "+String:C10(UnitTest_TotalTests))
		UnitTest_LogMessage("Tests passed: "+String:C10(UnitTest_TotalPassed))
		UnitTest_LogMessage("Tests failed: "+String:C10(UnitTest_TotalFailed))
		
End case 
