//%attributes = {"invisible":true}
// Tokenize_LineOfCode_AddToArrays (tokenArray; Item1{; Item2})
// Tokenize_LineOfCode_AddToArrays (ptr; text{; text})
// 
// DESCRIPTION
//   A method that adds the two item1 to the tokenArray if they
//   they are not empty.
//
C_POINTER:C301($1; $ap_tokenArrayPtr)
C_TEXT:C284($2; $vt_item1)
C_TEXT:C284($3; $vt_item2)  // OPTIONAL
// ----------------------------------------------------
// HISTORY
//   Created by: DB (04/03/2017)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 2; 3; Count parameters:C259))
	$ap_tokenArrayPtr:=$1
	$vt_item1:=$2
	If ($vt_item1#"")
		APPEND TO ARRAY:C911($ap_tokenArrayPtr->; $vt_item1)
		//APPEND TO ARRAY($ap_tokenArrayPtr->;STR_TrimExcessSpaces ($vt_item1))
	End if 
	
	If (Count parameters:C259>=3)
		$vt_item2:=$3
		If ($vt_item2#"")
			APPEND TO ARRAY:C911($ap_tokenArrayPtr->; $vt_item2)
		End if 
	End if 
End if   // ASSERT

