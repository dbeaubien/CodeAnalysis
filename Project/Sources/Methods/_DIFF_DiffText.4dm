//%attributes = {"invisible":true}
// _DIFF_DiffText
//
// DESCRIPTION
//   Find the difference in 2 texts, comparing by textlines.
//
//   The algorithm itself is comparing 2 arrays of numbers so when comparing 2 text documents
//   each line is converted into a (hash) number. This hash-value is computed by storing all
//   textlines into a common hashtable so i can find dublicates in there, and generating a 
//   new number each time a new textline is inserted.
//
//   A array of Items containing the differences is returned.
//
#DECLARE($A_t : Text\
; $B_t : Text\
; $StartA_ptr : Pointer\
; $StartB_ptr : Pointer\
; $DeletedA_ptr : Pointer\
; $InsertedB_ptr : Pointer)
// ----------------------------------------------------

var $LengthA_l; $LengthB_l : Integer
$LengthA_l:=Length:C16($A_t)
$LengthB_l:=Length:C16($B_t)

var $Char_l : Integer

ARRAY TEXT:C222($A; $LengthA_l)
For ($Char_l; 1; $LengthA_l)
	$A{$Char_l}:=$A_t[[$Char_l]]
End for 

ARRAY TEXT:C222($B; $LengthB_l)
For ($Char_l; 1; $LengthB_l)
	$B{$Char_l}:=$B_t[[$Char_l]]
End for 

_DIFF_Diff(->$A; ->$B; $StartA_ptr; $StartB_ptr; $DeletedA_ptr; $InsertedB_ptr)

