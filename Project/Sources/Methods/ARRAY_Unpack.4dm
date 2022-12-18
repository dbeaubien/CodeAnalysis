//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: Method: Array_Unpack
// Description
// Unpack text to the given array using the given delimiter
//
// ----------------------------------------------------
// User name (OS): DavidD
// Date and time: 23/03/05, 09:48:58
// ----------------------------------------------------
// Parameters
C_TEXT:C284($1; $packedText_t)
C_POINTER:C301($2; $array_ptr)
C_TEXT:C284($3; $delimiter_t)
C_LONGINT:C283($0; $arraySize_l)

$packedText_t:=$1
$array_ptr:=$2
If (Count parameters:C259>2)
	$delimiter_t:=$3
Else 
	$delimiter_t:=Char:C90(Carriage return:K15:38)  //use carriage return by default
End if 

//   Mod by: Dani Beaubien (02/17/2014)
C_LONGINT:C283($delimiterLength_l)
$delimiterLength_l:=Length:C16($delimiter_t)

Array_SetSize(0; $array_ptr)

C_LONGINT:C283($type_l)
$type_l:=Type:C295($array_ptr->)

C_LONGINT:C283($delimPos_l; $lastDelimPos_l)
C_TEXT:C284($elementText_t)

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

$0:=Size of array:C274($array_ptr->)




