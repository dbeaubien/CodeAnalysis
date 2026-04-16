//%attributes = {"invisible":true}
// Method_FixSpecialCharacters (MethodNameArray)
//
// DESCRIPTION
//   This method scans the passed array and converts any %xx
//   encoded characters back to their "correct" value.
//
#DECLARE($ap_methodNamesArrPtr : Pointer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	var $vt_buffer; $vt_theChar : Text
	var $start; $pos; $len; $index : Integer
	var $i : Integer
	For ($i; 1; Size of array:C274($ap_methodNamesArrPtr->))
		$vt_buffer:=$ap_methodNamesArrPtr->{$i}
		
		If (Position:C15("%"; $vt_buffer)>0)
			$ap_methodNamesArrPtr->{$i}:=STR_URLDecode($vt_buffer)
		End if 
		
	End for 
	
End if 