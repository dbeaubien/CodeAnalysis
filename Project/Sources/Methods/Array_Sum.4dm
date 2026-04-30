//%attributes = {"invisible":true}
// Array_Sum (arrayPtr) : sum
// 
// DESCRIPTION
//   Returns the sum of the the values in the array.
//
#DECLARE($array_ptr : Pointer)->$sum : Integer
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$sum:=0

var $i : Integer
For ($i; 1; Size of array:C274($array_ptr->))
	$sum+=$array_ptr->{$i}
End for 
