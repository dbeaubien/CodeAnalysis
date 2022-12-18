//%attributes = {"invisible":true}
// (PM) MethodStats__UnitTests 
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
			UnitTest_RunTest("Nesting Stats")
			UnitTest_RunTest("Field References")
			
			
		: ($action="Setup")
			Tokenize__Init(True:C214)
			Structure__Init
			
		: ($action="TearDown")
			// n/a
			
		: ($action="Nesting Stats")
			C_TEXT:C284($vt_lineOfCode)
			$vt_lineOfCode:="If (DEV_ASSERT_PARMCOUNT (Current method name;1;Count parameters))"
			UnitTest_AssertTrue(MethodStats_IsLineIndent($vt_lineOfCode))
			UnitTest_AssertFalse(MethodStats_IsLineOutdent($vt_lineOfCode))
			
			$vt_lineOfCode:="Else"
			UnitTest_AssertTrue(MethodStats_IsLineIndent($vt_lineOfCode))
			UnitTest_AssertTrue(MethodStats_IsLineOutdent($vt_lineOfCode))
			
			$vt_lineOfCode:="End if"
			UnitTest_AssertFalse(MethodStats_IsLineIndent($vt_lineOfCode))
			UnitTest_AssertTrue(MethodStats_IsLineOutdent($vt_lineOfCode))
			
			$vt_lineOfCode:="Case of"
			UnitTest_AssertTrue(MethodStats_IsLineIndent($vt_lineOfCode))
			UnitTest_AssertFalse(MethodStats_IsLineOutdent($vt_lineOfCode))
			
			$vt_lineOfCode:="End case"
			UnitTest_AssertFalse(MethodStats_IsLineIndent($vt_lineOfCode))
			UnitTest_AssertTrue(MethodStats_IsLineOutdent($vt_lineOfCode))
			
			$vt_lineOfCode:="Repeat"
			UnitTest_AssertTrue(MethodStats_IsLineIndent($vt_lineOfCode))
			UnitTest_AssertFalse(MethodStats_IsLineOutdent($vt_lineOfCode))
			
			$vt_lineOfCode:="Until ($pos<0)"
			UnitTest_AssertFalse(MethodStats_IsLineIndent($vt_lineOfCode))
			UnitTest_AssertTrue(MethodStats_IsLineOutdent($vt_lineOfCode))
			
			$vt_lineOfCode:="While ($Continue)"
			UnitTest_AssertTrue(MethodStats_IsLineIndent($vt_lineOfCode))
			UnitTest_AssertFalse(MethodStats_IsLineOutdent($vt_lineOfCode))
			
			$vt_lineOfCode:="End while"
			UnitTest_AssertFalse(MethodStats_IsLineIndent($vt_lineOfCode))
			UnitTest_AssertTrue(MethodStats_IsLineOutdent($vt_lineOfCode))
			
			$vt_lineOfCode:="For ($i;1;Size of array($at_sourceMethod))"
			UnitTest_AssertTrue(MethodStats_IsLineIndent($vt_lineOfCode))
			UnitTest_AssertFalse(MethodStats_IsLineOutdent($vt_lineOfCode))
			
			$vt_lineOfCode:="End For"
			UnitTest_AssertFalse(MethodStats_IsLineIndent($vt_lineOfCode))
			UnitTest_AssertTrue(MethodStats_IsLineOutdent($vt_lineOfCode))
			
			
		: ($action="Field References")
			// Find a valid table & field 
			ARRAY TEXT:C222($at_FLD_tableNames; 0)
			ARRAY TEXT:C222($at_FLD_tableFieldNames; 0)
			ARRAY BOOLEAN:C223($ab_FLD_hasIndex; 0)
			OB GET ARRAY:C1229(_STRUCT_ObjOfArrays; "tableNames"; $at_FLD_tableNames)
			OB GET ARRAY:C1229(_STRUCT_ObjOfArrays; "tableFieldNames"; $at_FLD_tableFieldNames)
			OB GET ARRAY:C1229(_STRUCT_ObjOfArrays; "fieldIsIndexed"; $ab_FLD_hasIndex)
			
			If (Size of array:C274($ab_FLD_hasIndex)>0)
				C_LONGINT:C283($pos)
				$pos:=0
				Repeat 
					$pos:=$pos+1
				Until ($ab_FLD_hasIndex{$pos} | ($pos=Size of array:C274($ab_FLD_hasIndex)))
				
				
				If ($ab_FLD_hasIndex{$pos})
					C_LONGINT:C283($progHdl)
					$progHdl:=Progress New
					Progress SET TITLE($progHdl; "Checking Ability to locate field references"; -1; "Checking..."; True:C214)
					
					C_LONGINT:C283($i)
					For ($i; 1; 2000)
						If (Mod:C98($i; 51)=0)
							Progress SET PROGRESS($progHdl; $i/2000)
						End if 
						$vt_lineOfCode:=Command name:C538($i)
						If ($vt_lineOfCode#"")
							$vt_lineOfCode:=$vt_lineOfCode+"("+$at_FLD_tableFieldNames{$pos}+";"+$at_FLD_tableFieldNames{$pos}+";"+$at_FLD_tableFieldNames{$pos}+";"+$at_FLD_tableFieldNames{$pos}+")"
							Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
							Case of 
								: ($i=277) | ($i=341)  // QUERY & QUERY SELECTION
									UnitTest_AssertEqualLongint(5; MethodStats__GetPosOfFieldRef(->$at_tokens; $i; 1))
									
								: ($i=644) | ($i=1050) | ($i=339) | ($i=653) | ($i=1) | ($i=3) | ($i=4)
									UnitTest_AssertEqualLongint(3; MethodStats__GetPosOfFieldRef(->$at_tokens; $i; 1))  // QUERY SELECTION WITH ARRAY test
									
								Else 
									UnitTest_AssertEqualLongint(0; MethodStats__GetPosOfFieldRef(->$at_tokens; $i; 1))  // generic test
							End case 
						End if 
					End for 
					Progress QUIT($progHdl)
					
					// QUERY -- Command Name (277)
					$vt_lineOfCode:=Command name:C538(277)+"("+$at_FLD_tableNames{$pos}+"; & ;"+$at_FLD_tableFieldNames{$pos}+"=\"asfd\")"
					Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
					UnitTest_AssertEqualLongint(7; MethodStats__GetPosOfFieldRef(->$at_tokens; 277; 1))  // QUERY test
					
					// QUERY SELECTION -- Command Name (341)
					$vt_lineOfCode:=Command name:C538(341)+"("+$at_FLD_tableNames{$pos}+"; & ;"+$at_FLD_tableFieldNames{$pos}+"=\"asfd\")"
					Tokenize_LineOfCode($vt_lineOfCode; ->$at_tokens)
					UnitTest_AssertEqualLongint(7; MethodStats__GetPosOfFieldRef(->$at_tokens; 341; 1))  // QUERY SELECTION test
					
				End if 
			End if 
			
	End case 
End if 