//%attributes = {"invisible":true}
// Tokenize_LineOfCode_AddToArrays (tokenArray; Item1{; Item2})
// 
// DESCRIPTION
//   A method that adds the two item1 to the tokenArray if they
//   they are not empty.
//
#DECLARE($token_arr_ptr : Pointer\
; $item1 : Text\
; $item2 : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 2; 3; Count parameters:C259))
	If ($item1#"")
		APPEND TO ARRAY:C911($token_arr_ptr->; $item1)
	End if 
	
	If ($item2#"")
		APPEND TO ARRAY:C911($token_arr_ptr->; $item2)
	End if 
End if 

