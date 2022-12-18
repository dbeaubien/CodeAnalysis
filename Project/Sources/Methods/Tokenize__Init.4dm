//%attributes = {"invisible":true,"preemptive":"capable"}
// Tokenize__Init ({forceReset}) 
// Tokenize__Init ({boolean}) 
//
// DESCRIPTION
//   
//
C_BOOLEAN:C305($1; $vb_forceReset)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (02/25/2017)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259<=1)
If (Count parameters:C259>=1)
	$vb_forceReset:=$1
End if 

C_BOOLEAN:C305(_tokenizeInitd)
If ($vb_forceReset) | (Not:C34(_tokenizeInitd))
	_tokenizeInitd:=True:C214
	
	Structure__Init
	ARRAY TEXT:C222(_CODELINE_original; 0)
	ARRAY OBJECT:C1221(_CODELINE_tokenized; 0)
End if 