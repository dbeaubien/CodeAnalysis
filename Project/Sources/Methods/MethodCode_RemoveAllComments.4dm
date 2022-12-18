//%attributes = {"invisible":true}
// MethodCode_RemoveAllComments (srcMethodCode) : trimmedMethodCode
// MethodCode_RemoveAllComments (text) : text
//
// DESCRIPTION
//   Removes all the comments from the method code.
//
C_TEXT:C284($1; $vt_srcMethodCode)
C_TEXT:C284($0; $vt_trimmedMethodCode)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/04/2012)
// ----------------------------------------------------

$vt_trimmedMethodCode:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_srcMethodCode:=$1
	
	If ($vt_srcMethodCode="//%attributes = {@")  // Is the first line the actual attribute line?
		
		ARRAY TEXT:C222($at_codeLines; 0)
		ARRAY_Unpack($vt_srcMethodCode; ->$at_codeLines; Pref_GetEOL)
		
		C_LONGINT:C283($i; $pos)
		For ($i; Size of array:C274($at_codeLines); 1; -1)
			If ($at_codeLines{$i}="//@")  // is current line a comment?
				DELETE FROM ARRAY:C228($at_codeLines; $i; 1)
			Else 
				$pos:=Position:C15("//"; $at_codeLines{$i})
				If ($pos>0)  // is there a comment on the line?
					$at_codeLines{$i}:=Substring:C12($at_codeLines{$i}; 1; $pos-1)
					$at_codeLines{$i}:=STR_TrimExcessSpaces($at_codeLines{$i})
				End if 
			End if 
			
		End for 
		
		$vt_trimmedMethodCode:=Array_ConvertToTextDelimited(->$at_codeLines; Pref_GetEOL)
	Else 
		$vt_trimmedMethodCode:=$vt_srcMethodCode
	End if 
	
End if   // ASSERT
$0:=$vt_trimmedMethodCode
