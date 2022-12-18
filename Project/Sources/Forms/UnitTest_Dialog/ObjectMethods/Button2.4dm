// (OM UnitTest_RunButton

If (Find in array:C230(UnitTest_TestCaseEnabled; True:C214)=-1)
	
	ALERT:C41("There are no testcases selected.\rSelect one or more testcases to run first.")
	
Else 
	
	// Run the selected testcases
	UnitTest_Init("stats")
	UnitTest__Stopwatch("start")
	
	C_LONGINT:C283($index)
	For ($index; 1; Size of array:C274(UnitTest_ListBoxTestCases))
		If (UnitTest_TestCaseEnabled{$index})
			UnitTest_RunTestCase(UnitTest_TestCases{$index})
		End if 
	End for 
	
	UnitTest__Stopwatch("stop")
	
	Case of 
		: (UnitTest_TotalFailed>0)
			FORM GOTO PAGE:C247(2)
			
		: (FORM Get current page:C276=1)
			FORM GOTO PAGE:C247(2)
			
		: (FORM Get current page:C276=2)
			// don't change page
			
		: (FORM Get current page:C276=3)
			// don't change page
			
		Else 
			FORM GOTO PAGE:C247(3)
	End case 
End if 
