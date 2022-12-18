//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodLines_CountBlankLines (methodLinesArr) : numBlankLines
// MethodLines_CountBlankLines (arrayTextPtr) : longint
// 
// DESCRIPTION
//   Returns the number of lines in the array that are 
//   blank lines.
//
C_POINTER:C301($1; $methodLinesArr)
C_LONGINT:C283($0; $numBlankLines)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (06/13/2017)
// ----------------------------------------------------

$numBlankLines:=0
If (Asserted:C1132(Count parameters:C259=1))
	ASSERT:C1129(Type:C295($1->)=Text array:K8:16)
	$methodLinesArr:=$1
	
	// Comment Line
	If (Size of array:C274($methodLinesArr->)>0)
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274($methodLinesArr->))
			If ($methodLinesArr->{$i}="")
				$numBlankLines:=$numBlankLines+1
			End if 
		End for 
	End if 
	
End if 
$0:=$numBlankLines