//%attributes = {"invisible":true}
// (PM) _DIFF__UnitTests 
// $1 = Action

// CALLED BY: UnitTest_Setup_CA

If (Count parameters:C259=0)
	UnitTest_RunAll
Else 
	C_TEXT:C284($1; $action)
	$action:=$1
	
	C_TEXT:C284($A; $B)
	C_LONGINT:C283($SES)
	ARRAY TEXT:C222($SMS; 0)
	Case of 
			
		: ($action="RunTests")
			UnitTest_RunTest("DIFF Algorithm")
			UnitTest_RunTest("SES Algorithm")
			
			
		: ($action="Setup")
			// n/a
			
		: ($action="TearDown")
			// n/a
			
		: ($action="DIFF Algorithm")
			$A:="a,b,c,d,e,f,g,h,i,j,k,l"
			$B:="0,1,2,3,4,5,6,7,8,9"
			UnitTest_AssertTrue(_DIFF_TEST_DiffTestStrings($A; $B; "12.10.1.1*"); "All-changes")
			
			$A:="a,b,c,d,e,f,g,h,i,j,k,l"
			$B:=$A
			UnitTest_AssertTrue(_DIFF_TEST_DiffTestStrings($A; $B; ""); "All-same")
			
			$A:="a,b,c,d,e,f"
			$B:="b,c,d,e,f,x"
			UnitTest_AssertTrue(_DIFF_TEST_DiffTestStrings($A; $B; "1.0.1.1*0.1.7.6*"); "Snake")
			
			$a:="c1,a,c2,b,c,d,e,g,h,i,j,c3,k,l"
			$b:="C1,a,C2,b,c,d,e,I1,e,g,h,i,j,C3,k,I2,l"
			UnitTest_AssertTrue(_DIFF_TEST_DiffTestStrings($a; $b; "1.1.1.1*1.1.3.3*0.2.8.8*1.1.12.14*0.1.14.16*"); "repro20020920")
			
			$a:="F"
			$b:="0,F,1,2,3,4,5,6,7"
			UnitTest_AssertTrue(_DIFF_TEST_DiffTestStrings($a; $b; "0.1.1.1*0.7.2.3*"); "repro20030207")
			
			$a:="HELLO,WORLD"
			$b:=",,hello,,,,world,"
			UnitTest_AssertTrue(_DIFF_TEST_DiffTestStrings($a; $b; "2.8.1.1*"); "repro20030409")
			
			$a:="a,b,-,c,d,e,f,f"
			$b:="a,b,x,c,e,f"
			UnitTest_AssertTrue(_DIFF_TEST_DiffTestStrings($a; $b; "1.1.3.3*1.0.5.5*1.0.8.7*"); "some-changes")
			
			$a:="a,a,a,a,a,a,a,a,a,a"
			$b:="a,a,a,a,-,a,a,a,a,a"
			UnitTest_AssertTrue(_DIFF_TEST_DiffTestStrings($a; $b; "0.1.5.5*1.0.10.11*"); "long chain of repeats test failed")
			
			
			
		: ($action="SES Algorithm")
			$A:="ABCABBA"
			$B:="CBABAC"
			UnitTest_AssertEqualLongint(5; _DIFF_SES(->$A; ->$B; ->$SMS))
			
			$A:="TRUSTED"
			$B:="TRYSTING"
			UnitTest_AssertEqualLongint(7; _DIFF_SES(->$A; ->$B; ->$SMS))
			
			$A:="STRICT"
			$B:="TRIES"
			UnitTest_AssertEqualLongint(5; _DIFF_SES(->$A; ->$B; ->$SMS))
			
			$A:="STRICT"
			$B:="TRIES"
			UnitTest_AssertEqualLongint(5; _DIFF_SES(->$A; ->$B; ->$SMS))
			
			$A:="STRICTLY"
			$B:="TIGHTLY"
			UnitTest_AssertEqualLongint(5; _DIFF_SES(->$A; ->$B; ->$SMS))
			
			$A:="abcdef"
			$B:="bcdefx"
			UnitTest_AssertEqualLongint(2; _DIFF_SES(->$A; ->$B; ->$SMS))
			
	End case 
End if 