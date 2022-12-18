//%attributes = {"invisible":true}
// (PM) NUM__UnitTests 
// $1 = Action

// CALLED BY: UnitTest_Setup_CA

If (Count parameters:C259=0)
	UnitTest_RunAll
Else 
	C_TEXT:C284($1; $action)
	
	$action:=$1
	
	Case of 
			
		: ($action="RunTests")
			UnitTest_RunTest("Utility Methods")
			
		: ($action="Setup")
			// n/a
			
		: ($action="TearDown")
			// n/a
			
		: ($action="Utility Methods")
			UnitTest_AssertEqualLongint(NUM_GetMaxLong(1; 100); 100)
			UnitTest_AssertEqualLongint(NUM_GetMaxLong(100; 100); 100)
			UnitTest_AssertEqualLongint(NUM_GetMaxLong(100; 1); 100)
			UnitTest_AssertEqualLongint(NUM_GetMaxLong(-1; -100); -1)
			UnitTest_AssertEqualLongint(NUM_GetMaxLong(-100; 100); 100)
			UnitTest_AssertEqualLongint(NUM_GetMaxLong(-100; -1); -1)
			
			UnitTest_AssertEqualLongint(NUM_GetMinLong(1; 100); 1)
			UnitTest_AssertEqualLongint(NUM_GetMinLong(100; 100); 100)
			UnitTest_AssertEqualLongint(NUM_GetMinLong(100; 1); 1)
			UnitTest_AssertEqualLongint(NUM_GetMinLong(-1; -100); -100)
			UnitTest_AssertEqualLongint(NUM_GetMinLong(-100; 100); -100)
			UnitTest_AssertEqualLongint(NUM_GetMinLong(-100; -1); -100)
			
			UnitTest_AssertEqualReal(NUM_GetMaxReal(1.1; 100.1); 100.1)
			UnitTest_AssertEqualReal(NUM_GetMaxReal(100.1; 100.1); 100.1)
			UnitTest_AssertEqualReal(NUM_GetMaxReal(100.1; 1.1); 100.1)
			UnitTest_AssertEqualReal(NUM_GetMaxReal(-1.1; -100.1); -1.1)
			UnitTest_AssertEqualReal(NUM_GetMaxReal(-100.1; 100.1); 100.1)
			UnitTest_AssertEqualReal(NUM_GetMaxReal(-100.1; -1.1); -1.1)
			UnitTest_AssertEqualReal(NUM_GetMaxReal(1; 100); 100)
			UnitTest_AssertEqualReal(NUM_GetMaxReal(-1; -100); -1)
			
			UnitTest_AssertEqualReal(NUM_GetMinReal(1.1; 100.1); 1.1)
			UnitTest_AssertEqualReal(NUM_GetMinReal(100.1; 100.1); 100.1)
			UnitTest_AssertEqualReal(NUM_GetMinReal(100.1; 1.1); 1.1)
			UnitTest_AssertEqualReal(NUM_GetMinReal(-1.1; -100.1); -100.1)
			UnitTest_AssertEqualReal(NUM_GetMinReal(-100.1; 100.1); -100.1)
			UnitTest_AssertEqualReal(NUM_GetMinReal(-100.1; -1.1); -100.1)
			UnitTest_AssertEqualReal(NUM_GetMinReal(1; 100); 1)
			UnitTest_AssertEqualReal(NUM_GetMinReal(-1; -100); -100)
			
			
		Else 
			UnitTest_Assert(False:C215; "unexpected action of \""+$action+"\".")
	End case 
End if 