//%attributes = {"invisible":true}
// (PM) UnitTest_RunAll
// Runs all unit tests


If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
	C_LONGINT:C283($index)
	
	// Initialise our variables and setup the test cases
	UnitTest_Init("all")
	UnitTest_Setup_CA
	UnitTest__Stopwatch("start")
	
	// Run all testcases
	For ($index; 1; Size of array:C274(UnitTest_TestCases))
		UnitTest_RunTestCase(UnitTest_TestCases{$index})
	End for 
	
	UnitTest__Stopwatch("stop")
End if 