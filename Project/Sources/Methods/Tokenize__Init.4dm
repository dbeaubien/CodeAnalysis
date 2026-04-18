//%attributes = {"invisible":true,"preemptive":"capable"}
// Tokenize__Init ({forceReset}) 
//
#DECLARE($vb_forceReset : Boolean)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259<=1)

var _tokenizeInitd : Boolean
If ($vb_forceReset) | (Not:C34(_tokenizeInitd))
	_tokenizeInitd:=True:C214
	
	Structure__Init
	ARRAY TEXT:C222(_CODELINE_original; 0)
	ARRAY OBJECT:C1221(_CODELINE_tokenized; 0)
End if 