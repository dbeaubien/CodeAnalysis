//%attributes = {"invisible":true,"preemptive":"capable"}
// Method_CodeToArray (codeText; codeArr) 
// 
// DESCRIPTION
//   Converts the text block into an array breaking on
//   a Carriage Return.
//
#DECLARE($codeText : Text; $codeArr : Pointer; $eol : Text)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=3))
	Array_ConvertFromTextDelimited($codeArr; $codeText; $eol)
End if 
