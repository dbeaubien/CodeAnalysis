//%attributes = {"invisible":true}
// MethodScan_IndentCodeInArray (arrayToIndent)
// MethodScan_IndentCodeInArray (pointer to array)
//
// DESCRIPTION
//   Takes an array of 4D Code (one line per element) and
//   indents it.
//
C_POINTER:C301($1; $at_linesOfCode_ArrPtr)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/02/2012)
//   Mod by: Dani Beaubien (10/14/2012) - Added support for French
// ----------------------------------------------------

Logging_Method_START(Current method name:C684)
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$at_linesOfCode_ArrPtr:=$1
	
	C_TEXT:C284($vt_spaces)
	$vt_spaces:=" "*Num:C11(Pref_GetPrefString("DIFF indentSpaces"; "2"))
	
	C_LONGINT:C283($vl_indentLevel; $i)
	C_TEXT:C284($vt_curLine)
	$vl_indentLevel:=0
	For ($i; 1; Size of array:C274($at_linesOfCode_ArrPtr->))
		$vt_curLine:=$at_linesOfCode_ArrPtr->{$i}
		
		If ($vt_curLine#"")
			
			If ($vt_curLine="//@")
				$at_linesOfCode_ArrPtr->{$i}:=$vt_spaces+($vt_spaces*$vl_indentLevel)+$vt_curLine  // indent one extra amount
				
			Else 
				
				If (MethodStats_IsLineOutdent($vt_curLine))
					$vl_indentLevel:=$vl_indentLevel-1
				End if 
				
				$at_linesOfCode_ArrPtr->{$i}:=($vt_spaces*$vl_indentLevel)+$vt_curLine
				
				If (MethodStats_IsLineIndent($vt_curLine))
					$vl_indentLevel:=$vl_indentLevel+1
				End if 
				
			End if 
			
		End if 
		
	End for 
	
End if   // ASSERT
Logging_Method_STOP(Current method name:C684)
