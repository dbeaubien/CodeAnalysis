//%attributes = {"invisible":true}
// _DIFF_ChangesText
//
#DECLARE($StartA_ptr : Pointer\
; $StartB_ptr : Pointer\
; $DeletedA_ptr : Pointer\
; $InsertedB_ptr : Pointer)->$Changes_t : Text
// ----------------------------------------------------
$Changes_t:=""

var $Line_l : Integer
For ($Line_l; 1; Size of array:C274($StartA_ptr->))
	$Changes_t:=$Changes_t+String:C10($DeletedA_ptr->{$Line_l})+"."+String:C10($InsertedB_ptr->{$Line_l})+"."+String:C10($StartA_ptr->{$Line_l})+"."+String:C10($StartB_ptr->{$Line_l})+"*"
End for 