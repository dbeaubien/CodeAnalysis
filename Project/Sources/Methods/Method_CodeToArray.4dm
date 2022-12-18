//%attributes = {"invisible":true,"preemptive":"capable"}
// Method_CodeToArray (codeText; codeArr) 
// Method_CodeToArray (text; pointer to text array) 
// 
// DESCRIPTION
//   Converts the text block into an array breaking on
//   a Carriage Return.
//
C_TEXT:C284($1; $codeText)
C_POINTER:C301($2; $codeArr)
C_TEXT:C284($3; $eol)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (06/14/2017)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=3))
	ASSERT:C1129(Type:C295($2->)=Text array:K8:16)
	$codeText:=$1
	$codeArr:=$2
	$eol:=$3
	
	Array_ConvertFromTextDelimited($codeArr; $codeText; $eol)
End if 
