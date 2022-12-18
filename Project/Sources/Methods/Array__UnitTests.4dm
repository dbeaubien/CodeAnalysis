//%attributes = {"invisible":true}
// (PM) Array__UnitTests 
// $1 = Action

// CALLED BY: UnitTest_Setup_CA

If (Count parameters:C259=0)
	UnitTest_Setup_CA
Else 
	C_TEXT:C284($1; $action)
	$action:=$1
	
	Case of 
			
		: ($action="RunTests")
			UnitTest_RunTest("Array_SetSize")
			UnitTest_RunTest("Array_Empty")
			UnitTest_RunTest("Array_TrimLeadingSpaces")
			UnitTest_RunTest("Array_ConvertFromTextDelimited")  //   Mod: DB (09/25/2012)  
			UnitTest_RunTest("Array_ConvertToTextDelimited")  //   Mod: DB (03/01/2013)
			UnitTest_RunTest("Array_RemoveElementIfExists")
			UnitTest_RunTest("Array_Sum")
			
			
			
		: ($action="Setup")
			// n/a
			
		: ($action="TearDown")
			// n/a
			
			
		: ($action="Array_Sum")
			ARRAY LONGINT:C221($numbers; 100)
			UnitTest_AssertEqualLongint(0; Array_Sum(->$numbers))
			
			APPEND TO ARRAY:C911($numbers; 10)
			UnitTest_AssertEqualLongint(10; Array_Sum(->$numbers))
			
			$numbers{3}:=99
			UnitTest_AssertEqualLongint(109; Array_Sum(->$numbers))
			
			$numbers{4}:=-10
			UnitTest_AssertEqualLongint(99; Array_Sum(->$numbers))
			
			
		: ($action="Array_SetSize")
			// test 1
			ARRAY LONGINT:C221($al; 0)
			ARRAY TEXT:C222($at; 0)
			ARRAY BOOLEAN:C223($ab; 0)
			ARRAY OBJECT:C1221($ao; 0)
			ARRAY DATE:C224($ad; 0)
			Array_SetSize(3; ->$al; ->$at; ->$ab; ->$ao; ->$ad)
			UnitTest_AssertArraySize(3; ->$al)
			UnitTest_AssertArraySize(3; ->$at)
			UnitTest_AssertArraySize(3; ->$ab)
			UnitTest_AssertArraySize(3; ->$ao)
			UnitTest_AssertArraySize(3; ->$ad)
			$al{1}:=1
			$al{2}:=2
			$al{3}:=3
			Array_SetSize(4; ->$al)
			UnitTest_AssertArraySize(4; ->$al)
			UnitTest_AssertEqualLongint(1; $al{1})
			UnitTest_AssertEqualLongint(2; $al{2})
			UnitTest_AssertEqualLongint(3; $al{3})
			UnitTest_AssertEqualLongint(0; $al{4})
			Array_SetSize(2; ->$al)
			UnitTest_AssertArraySize(2; ->$al)
			UnitTest_AssertEqualLongint(1; $al{1})
			UnitTest_AssertEqualLongint(2; $al{2})
			
			
			
		: ($action="Array_Empty")
			ARRAY TEXT:C222($at_someArray; 32)
			ARRAY DATE:C224($ad_someArray; 31234)
			ARRAY LONGINT:C221($al_someArray; 0)
			Array_Empty(->$at_someArray)
			Array_Empty(->$ad_someArray)
			Array_Empty(->$al_someArray)
			UnitTest_AssertArraySize(0; ->$at_someArray; "expected $at_someArray to be size 0")
			UnitTest_AssertArraySize(0; ->$ad_someArray; "expected $ad_someArray to be size 0")
			UnitTest_AssertArraySize(0; ->$al_someArray; "expected $al_someArray to be size 0")
			
			
			
		: ($action="Array_ConvertToTextDelimited")
			ARRAY TEXT:C222($at_someArray; 5)
			$at_someArray{1}:=" 1 "
			$at_someArray{2}:="2"
			$at_someArray{3}:="3"
			$at_someArray{4}:="4"
			$at_someArray{5}:=""
			UnitTest_AssertEqualText(" 1 ,2,3,4,"; Array_ConvertToTextDelimited(->$at_someArray))
			UnitTest_AssertEqualText(" 1 |2|3|4|"; Array_ConvertToTextDelimited(->$at_someArray; "|"))
			UnitTest_AssertEqualText(" 1 , 2, 3, 4, "; Array_ConvertToTextDelimited(->$at_someArray; ", "))
			
			
		: ($action="Array_ConvertFromTextDelimited")
			ARRAY TEXT:C222($at_someArray; 0)
			Array_ConvertFromTextDelimited(->$at_someArray; " 1 ,2,3,4,"; ",")
			UnitTest_AssertArraySize(5; ->$at_someArray)
			UnitTest_AssertEqualText(" 1 "; $at_someArray{1})
			If (Size of array:C274($at_someArray)=5)
				UnitTest_AssertEqualText(""; $at_someArray{5})
			End if 
			
			Array_ConvertFromTextDelimited(->$at_someArray; "1,2,3,,4"; ",")
			UnitTest_AssertArraySize(5; ->$at_someArray)
			UnitTest_AssertEqualText("1"; $at_someArray{1})
			If (Size of array:C274($at_someArray)=5)
				UnitTest_AssertEqualText("4"; $at_someArray{5})
			End if 
			
			Array_ConvertFromTextDelimited(->$at_someArray; ""; ",")
			UnitTest_AssertArraySize(0; ->$at_someArray)
			
			Array_ConvertFromTextDelimited(->$at_someArray; "1"; ",")
			UnitTest_AssertArraySize(1; ->$at_someArray)
			
			
		: ($action="Array_RemoveElementIfExists")
			ARRAY TEXT:C222($at_keyArray; 4)
			$at_keyArray{1}:="k1"
			$at_keyArray{2}:="k2"
			$at_keyArray{3}:="k22"
			$at_keyArray{4}:="k1"
			
			Array_RemoveElementIfExists(->$at_keyArray; "tt")
			UnitTest_AssertArraySize(4; ->$at_keyArray)
			Array_RemoveElementIfExists(->$at_keyArray; "k2")
			UnitTest_AssertArraySize(3; ->$at_keyArray)
			Array_RemoveElementIfExists(->$at_keyArray; "k1")
			UnitTest_AssertArraySize(1; ->$at_keyArray)
			Array_RemoveElementIfExists(->$at_keyArray; "@")
			UnitTest_AssertArraySize(0; ->$at_keyArray)
			
			
		: ($action="Array_TrimLeadingSpaces")
			ARRAY TEXT:C222($someArray; 0)
			APPEND TO ARRAY:C911($someArray; " test1")
			APPEND TO ARRAY:C911($someArray; " test2 ")
			APPEND TO ARRAY:C911($someArray; "    test3     ")
			APPEND TO ARRAY:C911($someArray; "test4     ")
			APPEND TO ARRAY:C911($someArray; "5test5     ")
			APPEND TO ARRAY:C911($someArray; "")
			Array_TrimLeadingSpaces(->$someArray)
			
			UnitTest_AssertEqualText("test1"; $someArray{1})
			UnitTest_AssertEqualText("test2 "; $someArray{2})
			UnitTest_AssertEqualText("test3     "; $someArray{3})
			UnitTest_AssertEqualText("test4     "; $someArray{4})
			UnitTest_AssertEqualText("5test5     "; $someArray{5})
			UnitTest_AssertEqualText(""; $someArray{6})
			
		Else 
			UnitTest_Assert(False:C215; "unexpected action of \""+$action+"\".")
			
	End case 
End if 