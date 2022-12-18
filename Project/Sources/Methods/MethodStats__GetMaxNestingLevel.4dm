//%attributes = {"invisible":true}
// MethodStats__GetMaxNestingLevel (arrayToIndent) : maxNestingLevel
// MethodStats__GetMaxNestingLevel (pointer to array) : longint
// 
// DESCRIPTION
//   Takes an array of 4D Code (one line per element) and
//   and determines the maximum nesting level.
//
C_POINTER:C301($1; $at_linesOfCode_ArrPtr)
C_LONGINT:C283($0; $vl_maxNestingLevel)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (07/20/2016)
// ----------------------------------------------------

$vl_maxNestingLevel:=0
Logging_Method_START(Current method name:C684)
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$at_linesOfCode_ArrPtr:=$1
	
	C_LONGINT:C283($vl_indentLevel)
	$vl_indentLevel:=0
	C_LONGINT:C283($i)
	C_TEXT:C284($vt_curLine)
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
	
End if   // ASSERT
Logging_Method_STOP(Current method name:C684)
$0:=$vl_maxNestingLevel