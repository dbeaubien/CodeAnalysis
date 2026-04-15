//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) Method__UnitTests 
// $1 = Action
// CALLED BY: UnitTest_Setup_COV
//
#DECLARE($action : Text)
// ----------------------------------------------------

Case of 
	: (Count parameters:C259=0)
		UnitTest_RunAll
		
	: ($action="RunTests")
		UnitTest_RunTest("Method_CodeToArray")
		
		
	: ($action="Setup")
		// n/a
		
	: ($action="TearDown")
		// n/a
		
	: ($action="Method_CodeToArray")
		var $code : Text
		ARRAY TEXT:C222($methodLinesArr; 0)
		
		$code:=""
		Method_CodeToArray($code; ->$methodLinesArr; Char:C90(Carriage return:K15:38))
		UnitTest_AssertEqualLongint(0; Size of array:C274($methodLinesArr))
		
		$code:="beep"
		Method_CodeToArray($code; ->$methodLinesArr; Char:C90(Carriage return:K15:38))
		UnitTest_AssertEqualLongint(1; Size of array:C274($methodLinesArr))
		
		$code:="beep\rbeep"
		Method_CodeToArray($code; ->$methodLinesArr; Char:C90(Carriage return:K15:38))
		UnitTest_AssertEqualLongint(2; Size of array:C274($methodLinesArr))
		
		$code:=" beep\r  beep  \r\rtoast"
		Method_CodeToArray($code; ->$methodLinesArr; Char:C90(Carriage return:K15:38))
		UnitTest_AssertEqualLongint(4; Size of array:C274($methodLinesArr))
		UnitTest_AssertEqualText(" beep"; $methodLinesArr{1})
		UnitTest_AssertEqualText("  beep  "; $methodLinesArr{2})
		UnitTest_AssertEqualText(""; $methodLinesArr{3})
		UnitTest_AssertEqualText("toast"; $methodLinesArr{4})
		
		$code:="beep\nbeep"
		Method_CodeToArray($code; ->$methodLinesArr; Char:C90(Carriage return:K15:38))
		UnitTest_AssertEqualLongint(1; Size of array:C274($methodLinesArr))
		
End case 
