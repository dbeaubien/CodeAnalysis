//%attributes = {"invisible":true}
// Method_FixSpecialCharacters (MethodNameArray)
// Method_FixSpecialCharacters (Pointer to Text Array) 
//
// DESCRIPTION
//   This method scans the passed array and converts any %xx
//   encoded characters back to their "correct" value.
//
C_POINTER:C301($1; $ap_methodNamesArrPtr)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/25/2013)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$ap_methodNamesArrPtr:=$1
	
	C_TEXT:C284($vt_buffer; $vt_theChar)
	C_LONGINT:C283($start; $pos; $len; $index)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($ap_methodNamesArrPtr->))
		$vt_buffer:=$ap_methodNamesArrPtr->{$i}
		
		If (Position:C15("%"; $vt_buffer)>0)
			$ap_methodNamesArrPtr->{$i}:=STR_URLDecode($vt_buffer)
		End if 
		
	End for 
	
End if   // ASSERT