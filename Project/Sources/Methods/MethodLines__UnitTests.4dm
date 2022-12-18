//%attributes = {}
// (PM) MethodLines__UnitTests 
// $1 = Action

// CALLED BY: UnitTest_Setup_COV

If (Count parameters:C259=0)
	UnitTest_RunAll
Else 
	C_TEXT:C284($1; $action)
	$action:=$1
	
	C_TEXT:C284($codeLine)
	Case of 
		: ($action="RunTests")
			UnitTest_RunTest("MethodLines_CountCommentLines")
			UnitTest_RunTest("MethodLines_CountBlankLines")
			UnitTest_RunTest("MethodLines_GetHeaderComment")
			UnitTest_RunTest("MethodLine_StoreMethodsCalled")
			
			
		: ($action="Setup")
			// n/a
			
		: ($action="TearDown")
			// n/a
			
			
			
		: ($action="MethodLine_StoreMethodsCalled")
			ARRAY TEXT:C222($someArray; 0)
			ARRAY TEXT:C222($tokens; 0)
			UnitTest_AssertEqualText(","; MethodLine_StoreMethodsCalled(->$tokens; ""; ->$someArray))
			UnitTest_AssertEqualText(","; MethodLine_StoreMethodsCalled(->$tokens; ","; ->$someArray))
			UnitTest_AssertEqualText(",test,"; MethodLine_StoreMethodsCalled(->$tokens; ",test,"; ->$someArray))
			
			Array_ConvertFromTextDelimited(->$tokens; "If;(;isMethodName;)"; ";")
			UnitTest_AssertEqualText(","; MethodLine_StoreMethodsCalled(->$tokens; ""; ->$someArray))
			APPEND TO ARRAY:C911($someArray; "otherMethodName")
			UnitTest_AssertEqualText(","; MethodLine_StoreMethodsCalled(->$tokens; ""; ->$someArray))
			APPEND TO ARRAY:C911($someArray; "isMethodName")
			UnitTest_AssertEqualText(",isMethodName,"; MethodLine_StoreMethodsCalled(->$tokens; ","; ->$someArray))
			UnitTest_AssertEqualText(",a,b,c,isMethodName,"; MethodLine_StoreMethodsCalled(->$tokens; ",a,b,c,"; ->$someArray))
			UnitTest_AssertEqualText(",a,b,c,isMethodName,"; MethodLine_StoreMethodsCalled(->$tokens; ",a,b,c,isMethodName,"; ->$someArray))
			
			
			
		: ($action="MethodLines_GetHeaderComment")
			ARRAY TEXT:C222($someArray; 0)
			UnitTest_AssertEqualText(""; MethodLines_GetHeaderComment(->$someArray; "\r"))
			
			APPEND TO ARRAY:C911($someArray; "")
			UnitTest_AssertEqualText(""; MethodLines_GetHeaderComment(->$someArray; "\r"))
			
			APPEND TO ARRAY:C911($someArray; "// test comment")
			UnitTest_AssertEqualText(""; MethodLines_GetHeaderComment(->$someArray; "\r"))
			
			ARRAY TEXT:C222($someArray; 0)
			APPEND TO ARRAY:C911($someArray; "//%attributes")
			APPEND TO ARRAY:C911($someArray; "// test comment")
			UnitTest_AssertEqualText(" test comment"; MethodLines_GetHeaderComment(->$someArray; "\r"))
			
			APPEND TO ARRAY:C911($someArray; "// test comment2")
			UnitTest_AssertEqualText(" test comment\r test comment2"; MethodLines_GetHeaderComment(->$someArray; "\r"))
			
			APPEND TO ARRAY:C911($someArray; "beep")
			UnitTest_AssertEqualText(" test comment\n test comment2"; MethodLines_GetHeaderComment(->$someArray; "\n"))
			
			ARRAY TEXT:C222($someArray; 0)
			APPEND TO ARRAY:C911($someArray; "//%attributes")
			APPEND TO ARRAY:C911($someArray; "beep")
			UnitTest_AssertEqualText(""; MethodLines_GetHeaderComment(->$someArray; "\r"))
			
			
		: ($action="MethodLines_CountBlankLines")
			ARRAY TEXT:C222($someArray; 0)
			UnitTest_AssertEqualLongint(0; MethodLines_CountBlankLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; ": ($action=\"MethodLines_CountCommentLines\")")
			UnitTest_AssertEqualLongint(0; MethodLines_CountBlankLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "If (Count parameters=0)")
			UnitTest_AssertEqualLongint(0; MethodLines_CountBlankLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "If (Count parameters=0) \\ Test")
			UnitTest_AssertEqualLongint(0; MethodLines_CountBlankLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "// If (Count parameters=0) // Test")
			UnitTest_AssertEqualLongint(0; MethodLines_CountBlankLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "//%attributes = {\"lang\":\"en\"} comment added and reserved by 4D.")
			UnitTest_AssertEqualLongint(0; MethodLines_CountBlankLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "")
			UnitTest_AssertEqualLongint(1; MethodLines_CountBlankLines(->$someArray))
			
			
		: ($action="MethodLines_CountCommentLines")
			ARRAY TEXT:C222($someArray; 0)
			UnitTest_AssertEqualLongint(0; MethodLines_CountCommentLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; ": ($action=\"MethodLines_CountCommentLines\")")
			UnitTest_AssertEqualLongint(0; MethodLines_CountCommentLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "If (Count parameters=0)")
			UnitTest_AssertEqualLongint(0; MethodLines_CountCommentLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "If (Count parameters=0) \\ Test")
			UnitTest_AssertEqualLongint(0; MethodLines_CountCommentLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "// If (Count parameters=0) // Test")
			UnitTest_AssertEqualLongint(1; MethodLines_CountCommentLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "//%attributes = {\"lang\":\"en\"} comment added and reserved by 4D.")
			UnitTest_AssertEqualLongint(1; MethodLines_CountCommentLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "")
			UnitTest_AssertEqualLongint(1; MethodLines_CountCommentLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "/* test */")
			UnitTest_AssertEqualLongint(2; MethodLines_CountCommentLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "BEEP")
			APPEND TO ARRAY:C911($someArray; "/* test ")
			APPEND TO ARRAY:C911($someArray; "BEEP")
			APPEND TO ARRAY:C911($someArray; "*/")
			UnitTest_AssertEqualLongint(5; MethodLines_CountCommentLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "/* test */ BEEP")
			APPEND TO ARRAY:C911($someArray; "BEEP /* test ")
			APPEND TO ARRAY:C911($someArray; "one more comment line*/")
			UnitTest_AssertEqualLongint(6; MethodLines_CountCommentLines(->$someArray))
			
			APPEND TO ARRAY:C911($someArray; "BEEP /* test ")
			APPEND TO ARRAY:C911($someArray; "one more comment line*/ BEEP ")
			UnitTest_AssertEqualLongint(6; MethodLines_CountCommentLines(->$someArray))
			
	End case 
End if 