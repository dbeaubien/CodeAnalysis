//%attributes = {"invisible":true}
// MethodCode_RemoveAllComments (srcMethodCode) : trimmedMethodCode
//
// DESCRIPTION
//   Removes all the comments from the method code.
//
#DECLARE($vt_srcMethodCode : Text)->$vt_trimmedMethodCode : Text
// ----------------------------------------------------

$vt_trimmedMethodCode:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	If ($vt_srcMethodCode="//%attributes = {@")  // Is the first line the actual attribute line?
		
		ARRAY TEXT:C222($at_codeLines; 0)
		ARRAY_Unpack($vt_srcMethodCode; ->$at_codeLines; Pref_GetEOL)
		
		var $i; $pos : Integer
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
	
End if 

