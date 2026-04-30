//%attributes = {"invisible":true}
// (PM) UnitTest__ResolvePointer
// Turns a pointer into a textual representation
// $1 = Pointer
// $0 = Text

#DECLARE($pointer : Pointer)->$text : Text

var $tableNr; $fieldNr : Integer
RESOLVE POINTER:C394($pointer; $text; $tableNr; $fieldNr)

Case of 
	: (($text#"") & ($tableNr=-1))
		// Nothing to do
		
	: (($text#"") & ($tableNr#-1))
		$text:=$text+"{"+String:C10($tableNr)+"}"
		
	: (($tableNr>0) & ($fieldNr=0))
		$text:="["+Table name:C256($tableNr)+"]"
		
	: (($tableNr>0) & ($fieldNr#0))
		$text:="["+Table name:C256($tableNr)+"]"+Field name:C257($tableNr; $fieldNr)
		
	Else 
		$text:="Nil"
End case 

