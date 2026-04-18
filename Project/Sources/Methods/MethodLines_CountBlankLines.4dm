//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodLines_CountBlankLines (methodLinesArr) : numBlankLines
// 
// DESCRIPTION
//   Returns the number of lines in the array that are 
//   blank lines.
//
#DECLARE($methodLinesArr : Pointer)->$numBlankLines : Integer
// ----------------------------------------------------
ASSERT:C1129(Type:C295($methodLinesArr->)=Text array:K8:16)
$numBlankLines:=0

If (Asserted:C1132(Count parameters:C259=1))
	
	If (Size of array:C274($methodLinesArr->)>0)
		var $i : Integer
		For ($i; 1; Size of array:C274($methodLinesArr->))
			If ($methodLinesArr->{$i}="")
				$numBlankLines:=$numBlankLines+1
			End if 
		End for 
	End if 
	
End if 
