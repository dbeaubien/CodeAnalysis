//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodLines_GetHeaderComment (methodLinesArr; eol) : headerComment
// MethodLines_GetHeaderComment (arrayTextPtr; text) : text
// 
// DESCRIPTION
//   Returns the comment block that appears at the start of the
//   method. Every comment is returned until a non-comment line
//   is encountered. Leading comment "//" are stripped out.
//   THe passed eol is used as the end of line character.
//
C_POINTER:C301($1; $methodLinesArr)
C_TEXT:C284($2; $eol)
C_TEXT:C284($0; $headerComment)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (08/22/2017)
// ----------------------------------------------------

$headerComment:=""
If (Asserted:C1132(Count parameters:C259=2))
	ASSERT:C1129(Type:C295($1->)=Text array:K8:16)
	$methodLinesArr:=$1
	$eol:=$2
	
	// Comment Line
	If (Size of array:C274($methodLinesArr->)>0)
		
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274($methodLinesArr->))
			Case of 
				: ($methodLinesArr->{$i}="//%attributes@")
					// do nothing
					
				: ($methodLinesArr->{$i}="//@")
					If ($headerComment#"")
						$headerComment:=$headerComment+$eol
					End if 
					$headerComment:=$headerComment+Substring:C12($methodLinesArr->{$i}; 3)
					
				Else   // break
					$i:=Size of array:C274($methodLinesArr->)+1
			End case 
		End for 
	End if 
	
End if 
$0:=$headerComment