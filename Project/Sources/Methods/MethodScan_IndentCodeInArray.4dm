//%attributes = {"invisible":true}
// MethodScan_IndentCodeInArray (arrayToIndent)
//
// DESCRIPTION
//   Takes an array of 4D Code (one line per element) and
//   indents it.
//
#DECLARE($at_linesOfCode_ArrPtr : Pointer)
// ----------------------------------------------------

Logging_Method_START(Current method name:C684)
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	var $vt_spaces : Text
	$vt_spaces:=" "*Num:C11(Pref_GetPrefString("DIFF indentSpaces"; "2"))
	
	var $vl_indentLevel; $i : Integer
	var $vt_curLine : Text
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
	
End if 
Logging_Method_STOP(Current method name:C684)
