//%attributes = {"invisible":true}
// STR_IsOneOf (srcTxt; choice1; ... ; choiceN) : match
// 
// DESCRIPTION
//   Returns true is the first parameter matches one of the other
//   parameters. Use this method to see if the value is part of a
//   certain list.
//
#DECLARE($source_text : Text;  ...  : Text)->$matchWasFound : Boolean
// ----------------------------------------------------
$matchWasFound:=False:C215

If (DEV_ASSERT(Count parameters:C259>=2; Current method name:C684+" expects at least 2 paramters."))
	
	var $i : Integer
	For ($i; 2; Count parameters:C259)
		If ($source_text=${$i})
			$matchWasFound:=True:C214
			$i:=10000  // break the loop
		End if 
	End for 
	
End if 
