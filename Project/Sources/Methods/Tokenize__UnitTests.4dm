//%attributes = {"invisible":true}
// (PM) Tokenize__UnitTests 
// $1 = Action

// CALLED BY: UnitTest_Setup_CA

If (Count parameters:C259=0)
	UnitTest_RunAll
Else 
	C_TEXT:C284($1; $action)
	$action:=$1
	
	ARRAY TEXT:C222($at_tokens; 0)
	
	Case of 
			
		: ($action="RunTests")
			UnitTest_RunTest("Basic")
			UnitTest_RunTest("Comments")
			UnitTest_RunTest("Extra Spaces")
			UnitTest_RunTest("Variables")
			UnitTest_RunTest("Operators")
			UnitTest_RunTest("Structure")
			
			
		: ($action="Setup")
			Tokenize__Init(True:C214)
			
		: ($action="TearDown")
			// n/a
			
			
		: ($action="Basic")
			C_TEXT:C284($vt_lineOfCode)
			$vt_lineOfCode:="For ($i;1;Storage.methodStatsSummary.numMethods)"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(8; ->$at_tokens)
			UnitTest_AssertEqualText(";"; $at_tokens{4})
			
			$vt_lineOfCode:=": ($action=\"Tokenize_LineOfCode\")  //   Mod: DB (06/27/2012)"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(7; ->$at_tokens)
			UnitTest_AssertEqualText("$action"; $at_tokens{3})
			UnitTest_AssertEqualText("\"Tokenize_LineOfCode\""; $at_tokens{5})
			
			$vt_lineOfCode:="SET DATABASE LOCALIZATION(\"EN\")"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(4; ->$at_tokens)
			UnitTest_AssertEqualText("SET DATABASE LOCALIZATION"; $at_tokens{1})
			UnitTest_AssertEqualText("("; $at_tokens{2})
			
			$vt_lineOfCode:="$vo_callersObj:=CA_GetMethodsCallingTheMethod (Current method name)"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(6; ->$at_tokens)
			
			$vt_lineOfCode:="For ($i;1;Storage.methodStatsSummary.numMethods)"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(8; ->$at_tokens)
			
			$vt_lineOfCode:="$someToken:=\"?\""
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(3; ->$at_tokens)
			UnitTest_AssertEqualText("\"?\""; $at_tokens{3})
			
			$vt_lineOfCode:="$someToken:=?12:45:45? + 1"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(5; ->$at_tokens)
			UnitTest_AssertEqualText("?12:45:45?"; $at_tokens{3})
			
			$vt_lineOfCode:="$someToken:=!2017-06-01! + 1"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(5; ->$at_tokens)
			UnitTest_AssertEqualText("!2017-06-01!"; $at_tokens{3})
			
			
		: ($action="Comments")
			$vt_lineOfCode:="a:=1// <>test"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(4; ->$at_tokens)
			UnitTest_AssertEqualText("// <>test"; $at_tokens{4})
			
			$vt_lineOfCode:="// Some Comment"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(1; ->$at_tokens)
			UnitTest_AssertEqualText($vt_lineOfCode; $at_tokens{1})
			
			$vt_lineOfCode:="/* Some Comment */"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(1; ->$at_tokens)
			UnitTest_AssertEqualText($vt_lineOfCode; $at_tokens{1})
			
			$vt_lineOfCode:="/* Some Comment "
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(1; ->$at_tokens)
			UnitTest_AssertEqualText($vt_lineOfCode; $at_tokens{1})
			
			$vt_lineOfCode:="   : (  $action  =  \"Tokenize_LineOfCode\" )//   Mod: DB (06/27/2012)"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(7; ->$at_tokens)
			UnitTest_AssertEqualText("$action"; $at_tokens{3})
			UnitTest_AssertEqualText("//   Mod: DB (06/27/2012)"; $at_tokens{7})
			
			
		: ($action="Extra Spaces")
			$vt_lineOfCode:="   : (  $action  =  \"Tokenize_LineOfCode\" )//   Mod: DB (06/27/2012)"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertEqualText("$action"; $at_tokens{3})
			UnitTest_AssertEqualText("\"Tokenize_LineOfCode\""; $at_tokens{5})
			
			$vt_lineOfCode:="    :    (   $action=\"Tokenize_LineOfCode\")  //   Mod: DB (06/27/2012)"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(7; ->$at_tokens)
			UnitTest_AssertEqualText("$action"; $at_tokens{3})
			UnitTest_AssertEqualText("\"Tokenize_LineOfCode\""; $at_tokens{5})
			
			$vt_lineOfCode:=":    ($action   =\"Tokenize_LineOfCode\"    )//   Mod: DB (06/27/2012)"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(7; ->$at_tokens)
			UnitTest_AssertEqualText("$action"; $at_tokens{3})
			UnitTest_AssertEqualText("\"Tokenize_LineOfCode\""; $at_tokens{5})
			
			$vt_lineOfCode:=" // Some Comment"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(1; ->$at_tokens)
			UnitTest_AssertEqualText("// Some Comment"; $at_tokens{1})  // leading spaces removed
			
			
			
		: ($action="Variables")
			$vt_lineOfCode:="$someToken:=45"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(3; ->$at_tokens)
			UnitTest_AssertEqualText("$someToken"; $at_tokens{1})
			
			$vt_lineOfCode:="<>someToken:=->testPointer"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(4; ->$at_tokens)
			UnitTest_AssertEqualText("->"; $at_tokens{3})
			UnitTest_AssertEqualText("testPointer"; $at_tokens{4})
			
			$vt_lineOfCode:="<>someToken:=45"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(3; ->$at_tokens)
			UnitTest_AssertEqualText("<>someToken"; $at_tokens{1})
			
			$vt_lineOfCode:="someToken:=45"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(3; ->$at_tokens)
			UnitTest_AssertEqualText("someToken"; $at_tokens{1})
			
			$vt_lineOfCode:="$someToken:=($someToken+someToken)*<>someToken"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(9; ->$at_tokens)
			UnitTest_AssertEqualText("$someToken"; $at_tokens{1})
			UnitTest_AssertEqualText("$someToken"; $at_tokens{4})
			UnitTest_AssertEqualText("someToken"; $at_tokens{6})
			UnitTest_AssertEqualText("<>someToken"; $at_tokens{9})
			
			
		: ($action="Operators")
			$vt_lineOfCode:="$someToken:=45*5+(4%4)-(1^6)"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(17; ->$at_tokens)
			UnitTest_AssertEqualText(":="; $at_tokens{2})
			UnitTest_AssertEqualText("*"; $at_tokens{4})
			UnitTest_AssertEqualText("+"; $at_tokens{6})
			UnitTest_AssertEqualText("%"; $at_tokens{9})
			UnitTest_AssertEqualText("-"; $at_tokens{12})
			UnitTest_AssertEqualText("^"; $at_tokens{15})
			
			$vt_lineOfCode:="if (a{1} > b[[1]])"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(12; ->$at_tokens)
			UnitTest_AssertEqualText("("; $at_tokens{2})
			UnitTest_AssertEqualText(")"; $at_tokens{12})
			UnitTest_AssertEqualText("{"; $at_tokens{4})
			UnitTest_AssertEqualText("}"; $at_tokens{6})
			UnitTest_AssertEqualText("[["; $at_tokens{9})
			UnitTest_AssertEqualText("]]"; $at_tokens{11})
			
			$vt_lineOfCode:="if ((a=b) | (b<c) | (d>e)) & (a#<>isDone)"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(26; ->$at_tokens)
			UnitTest_AssertEqualText("="; $at_tokens{5})
			UnitTest_AssertEqualText("|"; $at_tokens{8})
			UnitTest_AssertEqualText("<"; $at_tokens{11})
			UnitTest_AssertEqualText(">"; $at_tokens{17})
			UnitTest_AssertEqualText("&"; $at_tokens{21})
			UnitTest_AssertEqualText("#"; $at_tokens{24})
			
			$vt_lineOfCode:="if ((a<=b) & (b>=c))"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(14; ->$at_tokens)
			UnitTest_AssertEqualText("<="; $at_tokens{5})
			UnitTest_AssertEqualText(">="; $at_tokens{11})
			
			$vt_lineOfCode:="$someToken:=0x0000 ^| 0x00FF"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(5; ->$at_tokens)
			UnitTest_AssertEqualText("^|"; $at_tokens{4})
			
			$vt_lineOfCode:="$someToken:=somVar*+someVar2*/someVar3"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(7; ->$at_tokens)
			UnitTest_AssertEqualText("*+"; $at_tokens{4})
			UnitTest_AssertEqualText("*/"; $at_tokens{6})
			
			$vt_lineOfCode:="$someToken:=somVar << someVar2 >> someVar3"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(7; ->$at_tokens)
			UnitTest_AssertEqualText("<<"; $at_tokens{4})
			UnitTest_AssertEqualText(">>"; $at_tokens{6})
			
			$vt_lineOfCode:="$someToken:=somVar ?+ someVar2 ?- someVar3 ?? someVar4"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(9; ->$at_tokens)
			UnitTest_AssertEqualText("?+"; $at_tokens{4})
			UnitTest_AssertEqualText("?-"; $at_tokens{6})
			UnitTest_AssertEqualText("??"; $at_tokens{8})
			
			
		: ($action="Structure")
			$vt_lineOfCode:="query([Table_1];[Table_1]Field_1=\"test\")"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(8; ->$at_tokens)
			UnitTest_AssertEqualText("[Table_1]"; $at_tokens{3})
			UnitTest_AssertEqualText("[Table_1]Field_1"; $at_tokens{5})
			
			$vt_lineOfCode:="query(   [Table_1]  ;[Table_1]Field_1 =  \"test\")"
			Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
			UnitTest_AssertArraySize(8; ->$at_tokens)
			UnitTest_AssertEqualText("[Table_1]"; $at_tokens{3})
			UnitTest_AssertEqualText("[Table_1]Field_1"; $at_tokens{5})
			
	End case 
End if 