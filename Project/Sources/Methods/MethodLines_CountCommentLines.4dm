//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodLines_CountCommentLines (methodLinesArr) : numCommentLines
// 
// DESCRIPTION
//   Returns the number of lines in the array that are 
//   fully commented lines.
//
#DECLARE($methodLinesArr : Pointer)->$numCommentLines : Integer
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
ASSERT:C1129(Type:C295($methodLinesArr->)=Text array:K8:16)
$numCommentLines:=0

var $i : Integer
var $inComment : Boolean
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
