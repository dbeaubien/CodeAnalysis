//%attributes = {"invisible":true}
// (PM) UnitTest_SaveStats
// Saves the statistics of the unittest to a disk file
// $1 = Filename
//
#DECLARE($filename : Text)
// ----------------------------------------------------

var $doc : Time
$doc:=Create document:C266($filename)

If (OK=1)
	
	SAX OPEN XML ELEMENT:C853($doc; "unittest"; "date"; Substring:C12(String:C10(Current date:C33; 8); 1; 11)+String:C10(Current time:C178; HH MM SS:K7:1))
	
	var $index : Integer
	For ($index; 1; Size of array:C274(UnitTest_StatsTestCase))
		
		SAX OPEN XML ELEMENT:C853($doc; "test")
		
		SAX OPEN XML ELEMENT:C853($doc; "testcase")
		SAX ADD XML ELEMENT VALUE:C855($doc; UnitTest_StatsTestCase{$index})
		SAX CLOSE XML ELEMENT:C854($doc)
		
		SAX OPEN XML ELEMENT:C853($doc; "testname")
		SAX ADD XML ELEMENT VALUE:C855($doc; UnitTest_StatsTestName{$index})
		SAX CLOSE XML ELEMENT:C854($doc)
		
		SAX OPEN XML ELEMENT:C853($doc; "duration")
		SAX ADD XML ELEMENT VALUE:C855($doc; String:C10(UnitTest_StatsDuration{$index}))
		SAX CLOSE XML ELEMENT:C854($doc)
		
		SAX OPEN XML ELEMENT:C853($doc; "percentage")
		SAX ADD XML ELEMENT VALUE:C855($doc; String:C10(UnitTest_StatsPercentage{$index}))
		SAX CLOSE XML ELEMENT:C854($doc)
		
		SAX OPEN XML ELEMENT:C853($doc; "total")
		SAX ADD XML ELEMENT VALUE:C855($doc; String:C10(UnitTest_StatsTotal{$index}))
		SAX CLOSE XML ELEMENT:C854($doc)
		
		SAX OPEN XML ELEMENT:C853($doc; "passed")
		SAX ADD XML ELEMENT VALUE:C855($doc; String:C10(UnitTest_StatsPassed{$index}))
		SAX CLOSE XML ELEMENT:C854($doc)
		
		SAX OPEN XML ELEMENT:C853($doc; "failed")
		SAX ADD XML ELEMENT VALUE:C855($doc; String:C10(UnitTest_StatsFailed{$index}))
		SAX CLOSE XML ELEMENT:C854($doc)
		
		SAX CLOSE XML ELEMENT:C854($doc)
		
	End for 
	
	CLOSE DOCUMENT:C267($doc)
End if 
