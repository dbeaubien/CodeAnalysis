//%attributes = {"invisible":true}
// Array_Sum (arrayPtr) : sum
// Array_Sum (arrayPtr) : longint
// 
// DESCRIPTION
//   Returns the sum of the the values in the array.
//
C_POINTER:C301($1; $vp_arrayPtr)
C_LONGINT:C283($0; $vl_arraySum)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (01/06/2015)
// ----------------------------------------------------

$vl_arraySum:=0
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vp_arrayPtr:=$1
	
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($vp_arrayPtr->))
		$vl_arraySum:=$vl_arraySum+$vp_arrayPtr->{$i}
	End for 
End if   // ASSERT
$0:=$vl_arraySum