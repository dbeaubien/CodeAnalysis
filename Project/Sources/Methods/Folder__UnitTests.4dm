//%attributes = {"invisible":true}
// (PM) Folder__UnitTests 
// $1 = Action

// CALLED BY: UnitTest_Setup_ORCore


If (Count parameters:C259=0)
	UnitTest_RunAll
	
Else 
	C_TEXT:C284($1; $action)
	$action:=$1
	
	Case of 
			
		: ($action="RunTests")
			UnitTest_RunTest("Folder_EnsureEndsInSeparator")
			UnitTest_RunTest("Folder_ParentName")
			
			
		: ($action="Setup")
			// n/a
			
		: ($action="TearDown")
			// n/a
			
			
			
			
		: ($action="Folder_EnsureEndsInSeparator")
			UnitTest_AssertEqualText("test"+Folder separator:K24:12; Folder_EnsureEndsInSeparator("test"))
			UnitTest_AssertEqualText("test"+Folder separator:K24:12; Folder_EnsureEndsInSeparator("test"+Folder separator:K24:12))
			UnitTest_AssertEqualText(""; Folder_EnsureEndsInSeparator(""))
			UnitTest_AssertEqualText("test"+Folder separator:K24:12+"test"+Folder separator:K24:12; Folder_EnsureEndsInSeparator("test"+Folder separator:K24:12+"test"))
			UnitTest_AssertEqualText("test"+Folder separator:K24:12+"test"+Folder separator:K24:12; Folder_EnsureEndsInSeparator("test"+Folder separator:K24:12+"test"+Folder separator:K24:12))
			
		: ($action="Folder_ParentName")
			UnitTest_AssertEqualText("test"+Folder separator:K24:12; Folder_ParentName("test"+Folder separator:K24:12+"test"+Folder separator:K24:12); "t1")
			UnitTest_AssertEqualText("test"+Folder separator:K24:12; Folder_ParentName("test"+Folder separator:K24:12+"test"))
			UnitTest_AssertEqualText(""; Folder_ParentName("test"+Folder separator:K24:12))
			UnitTest_AssertEqualText(""; Folder_ParentName("test"))
			UnitTest_AssertEqualText(""; Folder_ParentName(""))
			
			
			
		Else 
			UnitTest_Assert(False:C215; "unexpected action of \""+$action+"\".")
			
	End case 
End if 
