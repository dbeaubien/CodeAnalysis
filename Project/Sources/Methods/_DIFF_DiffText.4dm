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
C_TEXT:C284($1; $A_t)
C_TEXT:C284($2; $B_t)
C_POINTER:C301($3; $StartA_ptr)
C_POINTER:C301($4; $StartB_ptr)
C_POINTER:C301($5; $DeletedA_ptr)
C_POINTER:C301($6; $InsertedB_ptr)
// ----------------------------------------------------
// HISTORY
//   Created by: ddancy (04/22/2008)
// ----------------------------------------------------

$A_t:=$1
$B_t:=$2
$StartA_ptr:=$3
$StartB_ptr:=$4
$DeletedA_ptr:=$5
$InsertedB_ptr:=$6

C_LONGINT:C283($LengthA_l; $LengthB_l)
$LengthA_l:=Length:C16($A_t)
$LengthB_l:=Length:C16($B_t)

C_LONGINT:C283($Char_l)

ARRAY TEXT:C222($A; $LengthA_l)
For ($Char_l; 1; $LengthA_l)
	$A{$Char_l}:=$A_t[[$Char_l]]
End for 

ARRAY TEXT:C222($B; $LengthB_l)
For ($Char_l; 1; $LengthB_l)
	$B{$Char_l}:=$B_t[[$Char_l]]
End for 

_DIFF_Diff(->$A; ->$B; $StartA_ptr; $StartB_ptr; $DeletedA_ptr; $InsertedB_ptr)

