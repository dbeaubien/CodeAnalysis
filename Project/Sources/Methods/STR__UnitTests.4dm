//%attributes = {"invisible":true}
// (PM) STR__UnitTests 
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
			UnitTest_AssertTrue(STR_IsOneOf("12"; "12"; "2"; "3"; "4"))
			UnitTest_AssertTrue(STR_IsOneOf("2"; "12"; "2"; "3"; "4"))
			UnitTest_AssertTrue(STR_IsOneOf("3"; "12"; "2"; "3"; "4"))
			UnitTest_AssertTrue(STR_IsOneOf("4"; "12"; "2"; "3"; "4"))
			UnitTest_AssertFalse(STR_IsOneOf("1@"; "12"; "2"; "3"; "4"))
			UnitTest_AssertFalse(STR_IsOneOf("Happy"; "12"; "2"; "3"; "4"))
			
			UnitTest_AssertEqualText("Happy ./Place"; JSON_EncodeString("Happy ./Place"))
			UnitTest_AssertEqualText("Happy Place"; JSON_EncodeString("Happy Place"))
			UnitTest_AssertEqualText("Happy \\\\Place"; JSON_EncodeString("Happy \\Place"))
			UnitTest_AssertEqualText("Happy \\\"Place"; JSON_EncodeString("Happy \"Place"))
			UnitTest_AssertEqualText("Happy \\tPlace"; JSON_EncodeString("Happy \tPlace"))
			UnitTest_AssertEqualText("Happy \\nPlace"; JSON_EncodeString("Happy "+Char:C90(Line feed:K15:40)+"Place"))
			UnitTest_AssertEqualText("Happy \\rPlace"; JSON_EncodeString("Happy "+Char:C90(Carriage return:K15:38)+"Place"))
			
			UnitTest_AssertEqualText("Happy%20./Place"; STR_URLEncode("Happy ./Place"))
			UnitTest_AssertEqualText("1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_.~"; STR_URLEncode("1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_.~"))
			UnitTest_AssertEqualText(":/.?=_-$(){}~&"; STR_URLEncode(":/.?=_-$(){}~&"))
			
	End case 
End if 