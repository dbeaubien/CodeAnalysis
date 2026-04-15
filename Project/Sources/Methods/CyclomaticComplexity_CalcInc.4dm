//%attributes = {"invisible":true}
// CyclomaticComplexity_CalcInc (array of tokens) : cyclomacticComplexityOfLine
// 
// DESCRIPTION
//   Calculates the increment that should be applied to the 
//   Cyclomatic Complexity based on the tokenized line passed
//   to the function.
//
#DECLARE($tokenArrPtr : Pointer)->$increment : Integer
// ----------------------------------------------------
$increment:=0

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	var $vt_tmpTxt : Text
	If (Size of array:C274($tokenArrPtr->)>0)
		If (STR_IsOneOf($tokenArrPtr->{1}; "If"; "Si"))
			If (Size of array:C274($tokenArrPtr->)>=4)  // ignore "if (true)" and "if (false)" statements
				$vt_tmpTxt:=$tokenArrPtr->{2}+$tokenArrPtr->{3}+$tokenArrPtr->{4}
				If ($vt_tmpTxt#("("+Command name:C538(214)+")")) & ($vt_tmpTxt#("("+Command name:C538(215)+")"))  // (True) or (False)
					$increment:=1
				End if 
			Else 
				$increment:=1
			End if 
			
		Else 
			If (STR_IsOneOf($tokenArrPtr->{1}; ":"; "Else"; "Sinon"; "For"; "Boucle"; "While"; "Tant que"; "Until"; "Jusque"))
				$increment:=1
			End if 
		End if 
	End if 
	
End if 
