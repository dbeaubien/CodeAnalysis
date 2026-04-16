//%attributes = {"invisible":true}
// MethodStats__GetMaxNestingLevel (arrayToIndent) : maxNestingLevel
// 
// DESCRIPTION
//   Takes an array of 4D Code (one line per element) and
//   and determines the maximum nesting level.
//
#DECLARE($at_linesOfCode_ArrPtr : Pointer)->$vl_maxNestingLevel : Integer
// ----------------------------------------------------

$vl_maxNestingLevel:=0
Logging_Method_START(Current method name:C684)
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	var $vl_indentLevel : Integer
	$vl_indentLevel:=0
	var $i : Integer
	var $vt_curLine : Text
	For ($i; 1; Size of array:C274($at_linesOfCode_ArrPtr->))
		$vt_curLine:=$at_linesOfCode_ArrPtr->{$i}
		
		If ($vt_curLine#"") & ($vt_curLine#"//@")
			If (MethodStats_IsLineOutdent($vt_curLine))
				$vl_indentLevel:=$vl_indentLevel-1
			End if 
			
			If (MethodStats_IsLineIndent($vt_curLine))
				$vl_indentLevel:=$vl_indentLevel+1
			End if 
			
			If ($vl_maxNestingLevel<$vl_indentLevel)
				$vl_maxNestingLevel:=$vl_indentLevel
			End if 
			
		End if 
		
	End for 
	
End if 
Logging_Method_STOP(Current method name:C684)
