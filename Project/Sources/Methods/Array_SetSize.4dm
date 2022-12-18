//%attributes = {"invisible":true}
// (PM) Array_SetSize
// Changes the size of one or multiple arrays
// $1 = Size
// $2 etc. = Pointers to arrays

C_LONGINT:C283($1; $size)
C_LONGINT:C283($param; $currentSize)
C_POINTER:C301(${2}; $array)

$size:=$1
$array:=$2

For ($param; 2; Count parameters:C259)
	$array:=${$param}
	$currentSize:=Size of array:C274($array->)
	
	Case of 
		: ($currentSize<$size)
			INSERT IN ARRAY:C227($array->; $currentSize+1; $size-$currentSize)
			
		: ($currentSize>$size)
			If ($size<0)
				DELETE FROM ARRAY:C228($array->; $size+1; $currentSize)
			Else 
				DELETE FROM ARRAY:C228($array->; $size+1; $currentSize-$size)
			End if 
			
		Else 
			// NOP
	End case 
	
End for 