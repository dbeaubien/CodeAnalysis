//%attributes = {"invisible":true}
// Array_Unpack
//
// Unpack text to the given array using the given delimiter
//
#DECLARE($packedText_t : Text\
; $array_ptr : Pointer\
; $delimiter_t : Text) : Integer
// ----------------------------------------------------

If ($delimiter_t="")
	$delimiter_t:=Char:C90(Carriage return:K15:38)  //use carriage return by default
End if 

//   Mod by: Dani Beaubien (02/17/2014)
var $delimiterLength_l : Integer
$delimiterLength_l:=Length:C16($delimiter_t)

Array_SetSize(0; $array_ptr)

var $type_l : Integer
$type_l:=Type:C295($array_ptr->)

var $delimPos_l; $lastDelimPos_l : Integer
var $elementText_t : Text

If ($packedText_t#"")
	$lastDelimPos_l:=1
	Repeat 
		$delimPos_l:=Position:C15($delimiter_t; $packedText_t)
		If ($delimPos_l>0)
			$elementText_t:=Substring:C12($packedText_t; $lastDelimPos_l; ($delimPos_l-$lastDelimPos_l))
		Else 
			$elementText_t:=$packedText_t
		End if 
		
		Case of 
			: (($type_l=Text array:K8:16) | ($type_l=String array:K8:15))
				APPEND TO ARRAY:C911($array_ptr->; $elementText_t)
				
			: (($type_l=Real array:K8:17) | ($type_l=Integer array:K8:18) | ($type_l=LongInt array:K8:19))
				APPEND TO ARRAY:C911($array_ptr->; Num:C11($elementText_t))
				
			: ($type_l=Date array:K8:20)
				APPEND TO ARRAY:C911($array_ptr->; Date:C102($elementText_t))
				
			: ($type_l=Boolean array:K8:21)
				APPEND TO ARRAY:C911($array_ptr->; ($elementText_t="True"))
				
			: ($type_l=Pointer array:K8:23)
				APPEND TO ARRAY:C911($array_ptr->; Get pointer:C304($elementText_t))
				
		End case 
		$packedText_t:=Substring:C12($packedText_t; $delimPos_l+$delimiterLength_l)
	Until ($delimPos_l<=0)
End if 

return Size of array:C274($array_ptr->)