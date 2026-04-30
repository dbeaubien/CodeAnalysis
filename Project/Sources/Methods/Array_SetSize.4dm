//%attributes = {"invisible":true}
// (PM) Array_SetSize
// Changes the size of one or multiple arrays
// $1 = Size
// $2 etc. = Pointers to arrays
//
#DECLARE($size : Integer;  ...  : Pointer)
// ----------------------------------------------------

var $array : Pointer
var $param; $currentSize : Integer
For ($param; 2; Count parameters:C259)
	$array:=${$param}
	$currentSize:=Size of array:C274($array->)
	
	Case of 
		: ($currentSize<$size)
			INSERT IN ARRAY:C227($array->; $currentSize+1; $size-$currentSize)
			
		: ($currentSize>$size) && ($size<0)
			DELETE FROM ARRAY:C228($array->; $size+1; $currentSize)
			
		: ($currentSize>$size)
			DELETE FROM ARRAY:C228($array->; $size+1; $currentSize-$size)
			
		Else 
			// NOP
	End case 
	
End for 