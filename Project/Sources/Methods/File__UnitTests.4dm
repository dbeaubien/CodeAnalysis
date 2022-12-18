//%attributes = {"invisible":true}
// (PM) File__UnitTests 
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
			
			//File_Delete 
			//File_DoesExist 
			//File_VerifyitExist 
			//File_GetFolderName 
			
		: ($action="Setup")
			// n/a
			
		: ($action="TearDown")
			// n/a
			
			
		: ($action="Utility Methods")
			UnitTest_AssertEqualText(""; File_GetExtension("test"))
			UnitTest_AssertEqualText("test"; File_GetExtension("test.test"))
			UnitTest_AssertEqualText("zip"; File_GetExtension("test.txt.zip"))
			UnitTest_AssertEqualText(""; File_GetExtension("happy.place"+Folder separator:K24:12+"test"))
			
			UnitTest_AssertEqualText(""; File_GetFileName("test"+Folder separator:K24:12))
			UnitTest_AssertEqualText("test"; File_GetFileName("test"))
			UnitTest_AssertEqualText("tes$t"; File_GetFileName("tes$t"))
			UnitTest_AssertEqualText("word2"; File_GetFileName("word"+Folder separator:K24:12+"word2"))
			UnitTest_AssertEqualText("word2"; File_GetFileName("word"+Folder separator:K24:12+"word3"+Folder separator:K24:12+"word2"))
			
			
			C_TEXT:C284($vt_path)
			$vt_path:="Root"+Folder separator:K24:12+"child1"+Folder separator:K24:12+"child2"
			UnitTest_AssertEqualText("Root"+Folder separator:K24:12+"child1"+Folder separator:K24:12; File_GetFolderName($vt_path+Folder separator:K24:12))
			UnitTest_AssertEqualText("Root"+Folder separator:K24:12+"child1"+Folder separator:K24:12; File_GetFolderName($vt_path))
			
			$vt_path:="Root"
			UnitTest_AssertEqualText(""; File_GetFolderName($vt_path))
			UnitTest_AssertEqualText(""; File_GetFolderName($vt_path+Folder separator:K24:12))
			
			UnitTest_AssertEqualText("word"+Folder separator:K24:12; File_GetFolderName("word"+Folder separator:K24:12+"word2"))
			UnitTest_AssertEqualText("word"+Folder separator:K24:12+"word3"+Folder separator:K24:12; File_GetFolderName("word"+Folder separator:K24:12+"word3"+Folder separator:K24:12+"word2"))
			
			UnitTest_AssertEqualText(Structure file:C489; File_GetFolderName(Structure file:C489)+File_GetFileName(Structure file:C489))
			
		Else 
			UnitTest_Assert(False:C215; "unexpected action of \""+$action+"\".")
			
	End case 
End if 