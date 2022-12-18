//%attributes = {"invisible":true}
// (PM) Date__UnitTests 
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
			UnitTest_AssertEqualDate(Current date:C33; CurrentDate; "Currentdate did not return the correct date.")
			
			UnitTest_AssertEqualText("2011 - week 10"; DateTime_GetYearWeekNr(!2011-03-11!))  // Fri
			UnitTest_AssertEqualText("2011 - week 10"; DateTime_GetYearWeekNr(!2011-03-12!))  // Sat
			UnitTest_AssertEqualText("2011-10"; DateTime_GetYearWeekNr(!2011-03-13!; "yyyy-wk"))  // Sun
			UnitTest_AssertEqualText("11-2011"; DateTime_GetYearWeekNr(!2011-03-14!; "wk-yyyy"))  // Mon
			UnitTest_AssertEqualText("2011-11-11"; DateTime_GetYearWeekNr(!2011-03-15!; "yyyy-wk-wk"))  // Tue
			UnitTest_AssertEqualText("2011 - week 11"; DateTime_GetYearWeekNr(!2011-03-16!))  // Wed
			UnitTest_AssertEqualText("2011 - week 11"; DateTime_GetYearWeekNr(!2011-03-17!))  // Thu
			
			UnitTest_AssertEqualText("09/20/2006"; Date2String(!2006-09-20!))  // expect mm/dd/yyyy
			UnitTest_AssertEqualText("09/20"; Date2String(!2006-09-20!; "mm/dd"))
			UnitTest_AssertEqualText("09 2006"; Date2String(!2006-09-20!; "mm yyyy"))
			
			UnitTest_AssertEqualText("m 01 Jan January"; Date2String(!2006-01-20!; "m mm mon month"))
			UnitTest_AssertEqualText("m 02 Feb February"; Date2String(!2006-02-20!; "m mm mon month"))
			UnitTest_AssertEqualText("m 03 Mar March"; Date2String(!2006-03-20!; "m mm mon month"))
			UnitTest_AssertEqualText("m 04 Apr April"; Date2String(!2006-04-20!; "m mm mon month"))
			UnitTest_AssertEqualText("m 05 May May"; Date2String(!2006-05-20!; "m mm mon month"))
			UnitTest_AssertEqualText("m 06 Jun June"; Date2String(!2006-06-20!; "m mm mon month"))
			UnitTest_AssertEqualText("m 07 Jul July"; Date2String(!2006-07-20!; "m mm mon month"))
			UnitTest_AssertEqualText("m 08 Aug August"; Date2String(!2006-08-20!; "m mm mon month"))
			UnitTest_AssertEqualText("m 09 Sep September"; Date2String(!2006-09-20!; "m mm mon month"))
			UnitTest_AssertEqualText("m 10 Oct October"; Date2String(!2006-10-20!; "m mm mon month"))
			UnitTest_AssertEqualText("m 11 Nov November"; Date2String(!2006-11-20!; "m mm mon month"))
			UnitTest_AssertEqualText("m 12 Dec December"; Date2String(!2006-12-20!; "m mm mon month"))
			
			UnitTest_AssertEqualText("d 6 06 Wed Wednesday"; Date2String(!2006-09-06!; "d d1 dd dayshort day"))
			UnitTest_AssertEqualText("7 07 Thu Thursday"; Date2String(!2006-09-07!; "d1 dd dayshort day"))
			UnitTest_AssertEqualText("8 08 Fri Friday"; Date2String(!2006-09-08!; "d1 dd dayshort day"))
			UnitTest_AssertEqualText("9 09 Sat Saturday"; Date2String(!2006-09-09!; "d1 dd dayshort day"))
			UnitTest_AssertEqualText("10 10 Sun Sunday"; Date2String(!2006-09-10!; "d1 dd dayshort day"))
			UnitTest_AssertEqualText("11 11 Mon Monday"; Date2String(!2006-09-11!; "d1 dd dayshort day"))
			UnitTest_AssertEqualText("12 12 Tue Tuesday"; Date2String(!2006-09-12!; "d1 dd dayshort day"))
			
	End case 
End if 