//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodLines_CountCommentLines (methodLinesArr) : numCommentLines
// MethodLines_CountCommentLines (arrayTextPtr) : longint
// 
// DESCRIPTION
//   Returns the number of lines in the array that are 
//   fully commented lines.
//
C_POINTER:C301($1; $methodLinesArr)
C_LONGINT:C283($0; $numCommentLines)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (06/13/2017)
//   Mod by: Dani Beaubien (03/07/2021) - Support /* .. */ comments
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
ASSERT:C1129(Type:C295($1->)=Text array:K8:16)
$methodLinesArr:=$1
$numCommentLines:=0

C_LONGINT:C283($i)
C_BOOLEAN:C305($inComment)
For ($i; 1; Size of array:C274($methodLinesArr->))
	
	Case of 
		: ($methodLinesArr->{$i}="//@") & ($methodLinesArr->{$i}#"//%attributes@")  // classic 4D single line comment
			$numCommentLines:=$numCommentLines+1
			
		: (($methodLinesArr->{$i}="/*@*/"))  // Entire line is a single line comment
			$numCommentLines:=$numCommentLines+1
			
		: (($methodLinesArr->{$i}="/*@")) & (Not:C34($methodLinesArr->{$i}="/*@*/@")) & (Not:C34($inComment))
			$inComment:=True:C214
			$numCommentLines:=$numCommentLines+1
			
		: (($methodLinesArr->{$i}="@/*@")) & (Not:C34($methodLinesArr->{$i}="@/*@*/@")) & (Not:C34($inComment))
			// comment starts mid way in the line
			$inComment:=True:C214
			//$numCommentLines:=$numCommentLines+1
			
		: (($methodLinesArr->{$i}="@*/")) & ($inComment)
			$inComment:=False:C215
			$numCommentLines:=$numCommentLines+1
			
		: (($methodLinesArr->{$i}="@*/@")) & ($inComment)  // comments ends, but there is something after it
			$inComment:=False:C215
			
		: ($inComment)
			$numCommentLines:=$numCommentLines+1
			
	End case 
	
End for 

$0:=$numCommentLines