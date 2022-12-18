//%attributes = {"invisible":true}
// (PM) UnitTest_Init
// Initialises the variables used by the unittests
// $1 = What (all, testcases, stats)

C_TEXT:C284($1; $what)
C_TEXT:C284(UnitTest_CurrentTestCase; UnitTest_Log)
C_LONGINT:C283(UnitTest_StartTime; UnitTest_TotalTests; UnitTest_TotalPassed; UnitTest_TotalFailed)
C_REAL:C285(UnitTest_TotalDuration)

C_BOOLEAN:C305(UnitTest_hasInited)

If (Count parameters:C259=1)
	$what:=$1
Else 
	$what:="all"
End if 

Case of 
	: ($what="all_soft")
		If (Not:C34(UnitTest_hasInited))
			UnitTest_Init("all")
		End if 
		
	: ($what="all")
		UnitTest_hasInited:=True:C214
		UnitTest_Init("testcases")
		UnitTest_Init("stats")
		
	: ($what="testcases")
		ARRAY BOOLEAN:C223(UnitTest_TestCaseEnabled; 0)
		ARRAY TEXT:C222(UnitTest_TestCases; 0)
		
	: ($what="stats")
		UnitTest_CurrentTestCase:=""
		UnitTest_Log:=""
		UnitTest_TotalDuration:=0
		UnitTest_TotalTests:=0
		UnitTest_TotalPassed:=0
		UnitTest_TotalFailed:=0
		
		ARRAY TEXT:C222(UnitTest_StatsTestCase; 0)
		ARRAY TEXT:C222(UnitTest_StatsTestName; 0)
		ARRAY LONGINT:C221(UnitTest_StatsDuration; 0)
		ARRAY REAL:C219(UnitTest_StatsPercentage; 0)
		ARRAY LONGINT:C221(UnitTest_StatsTotal; 0)
		ARRAY LONGINT:C221(UnitTest_StatsPassed; 0)
		ARRAY LONGINT:C221(UnitTest_StatsFailed; 0)
		
End case 
