//%attributes = {"invisible":true,"preemptive":"capable"}
// Array_FindInSortedArray (sortedArr; valueToFind; position) : wasFound
// Array_FindInSortedArray (pointer; pointer; pointer) : boolean
//
// DESCRIPTION
//   Position will either be the position where the value was found OR
//   where the value should in inserted to add the item into the array.
//   "wasFound" will be true if the item exists.
//   See http://doc.4d.com/4Dv16/4D/16/Find-in-sorted-array.301-3036765.en.html
//
//   Adapted from "Binary Searches:, ACI US Technical note #28, May 1991 by Dave Terry.
//   TAKEN FROM http://4d.1045681.n5.nabble.com/Tip-Binary-insertion-code-tt5749745.html#a5749782
//
#DECLARE($array_pointer : Pointer\
; $value_pointer : Pointer\
; $position_ptr : Pointer)->$wasFound : Boolean
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=3)
$wasFound:=False:C215

var $result : Integer
$result:=0

var $high : Integer
var $low : Integer
var $current : Integer
var $size_of_array : Integer
$size_of_array:=Size of array:C274($array_pointer->)

Case of 
	: ($size_of_array=0)
		$wasFound:=False:C215
		$result:=1
		
	: (($value_pointer->)<($array_pointer->{1}))
		$wasFound:=False:C215
		$result:=1  // Less than item 1, use item 1. 
		
	: (($value_pointer->)=($array_pointer->{1}))
		$wasFound:=True:C214
		$result:=1  // equal to item 1, use item 1. 
		
	: (($value_pointer->)=($array_pointer->{$size_of_array}))
		$wasFound:=True:C214
		$result:=$size_of_array  // Equal to the last item, return it. 
		
	: (($value_pointer->)>($array_pointer->{$size_of_array}))
		$wasFound:=False:C215
		$result:=$size_of_array+1  // It's greater than the last element, specify new position.**This element does not exist yet.**
		
	Else 
		$low:=1
		$high:=Size of array:C274($array_pointer->)
		
		// Loop through until a match is found
		Repeat 
			$current:=$high+$low\2
			If ($value_pointer->>$array_pointer->{$current})
				$low:=$current
			Else 
				$high:=$current
			End if 
		Until ($low>=($high-1))
		$result:=$high
		
		$wasFound:=(($value_pointer->)=($array_pointer->{$result}))
End case 

$position_ptr->:=$result

