//%attributes = {"invisible":true}
// CyclomaticComplexity_CalcInc (array of tokens) : cyclomacticComplexityOfLine
// CyclomaticComplexity_CalcInc (pointer) : longint
// 
// DESCRIPTION
//   Calculates the increment that should be applied to the 
//   Cyclomatic Complexity based on the tokenized line passed
//   to the function.
//
C_POINTER:C301($1; $tokenArrPtr)
C_LONGINT:C283($0; $vl_increment)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (04/06/2017) - moved code to it's own method, easier to test and simplier
// ----------------------------------------------------

$vl_increment:=0
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$tokenArrPtr:=$1
	
	C_TEXT:C284($vt_tmpTxt)
	If (Size of array:C274($tokenArrPtr->)>0)
		If (STR_IsOneOf($tokenArrPtr->{1}; "If"; "Si"))
			If (Size of array:C274($tokenArrPtr->)>=4)  // ignore "if (true)" and "if (false)" statements
				$vt_tmpTxt:=$tokenArrPtr->{2}+$tokenArrPtr->{3}+$tokenArrPtr->{4}
				If ($vt_tmpTxt#("("+Command name:C538(214)+")")) & ($vt_tmpTxt#("("+Command name:C538(215)+")"))  // (True) or (False)
					$vl_increment:=1
				End if 
			Else 
				$vl_increment:=1
			End if 
			
		Else 
			If (STR_IsOneOf($tokenArrPtr->{1}; ":"; "Else"; "Sinon"; "For"; "Boucle"; "While"; "Tant que"; "Until"; "Jusque"))
				$vl_increment:=1
			End if 
		End if 
	End if 
	
End if   // ASSERT
$0:=$vl_increment