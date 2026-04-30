//%attributes = {"invisible":true}
// (PM) Tokenize__UnitTests 
// $1 = Action
// CALLED BY: UnitTest_Setup_CA
#DECLARE($action : Text)
// ----------------------------------------------------

ARRAY TEXT:C222($at_tokens; 0)
Case of 
	: (Count parameters:C259=0)
		UnitTest_RunAll
		
	: ($action="RunTests")
		UnitTest_RunTest("Cyclomatic Complexity Calculator")
		
	: ($action="Setup")
		Tokenize__Init(True:C214)
		
	: ($action="TearDown")
		// n/a
		
	: ($action="Cyclomatic Complexity Calculator")
		var $vt_lineOfCode : Text
		$vt_lineOfCode:="// query(   [Table_1]  ;[Table_1]Field_1 =  \"test\")"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(0; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="query(   [Table_1]  ;[Table_1]Field_1 =  \"test\")"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(0; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="If (True)"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(0; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="// If (True)"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(0; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="If (True) | (someotherCondition)"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(0; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="If (False)"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(0; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="If (False) //Test"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(0; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="If (STR_IsOneOf ($tokenArrPtr->{1};\"If\";\"Si\"))"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(1; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="// If (STR_IsOneOf ($tokenArrPtr->{1};\"If\";\"Si\"))"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(0; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="Else"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(1; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="Else // test"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(1; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="For ($i;1;Size of array(Storage.methodStatsSummary.numMethods))"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(1; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="While (($LineA<$DataALength) | ($LineB<$DataBLength))"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(1; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="Repeat   // REPEAT"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(0; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:="Until ($someValue)  // UNTIL"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(1; CyclomaticComplexity_CalcInc(->$at_tokens))
		
		$vt_lineOfCode:=": ($someValue)"
		Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
		UnitTest_AssertEqualLongint(1; CyclomaticComplexity_CalcInc(->$at_tokens))
		
End case 