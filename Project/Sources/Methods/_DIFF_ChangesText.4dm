//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): ddancy
// Date and time: 18/02/08, 16:34:47
// ----------------------------------------------------
// Method: _DIFF_ChangesText
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $StartA_ptr)
C_POINTER:C301($2; $StartB_ptr)
C_POINTER:C301($3; $DeletedA_ptr)
C_POINTER:C301($4; $InsertedB_ptr)
C_TEXT:C284($0; $Changes_t)

$StartA_ptr:=$1
$StartB_ptr:=$2
$DeletedA_ptr:=$3
$InsertedB_ptr:=$4

C_TEXT:C284($Changes_t)

If (Size of array:C274($StartA_ptr->)>0)
	
	C_LONGINT:C283($Line_l)
	
	For ($Line_l; 1; Size of array:C274($StartA_ptr->))
		$Changes_t:=$Changes_t+String:C10($DeletedA_ptr->{$Line_l})+"."+String:C10($InsertedB_ptr->{$Line_l})+"."+String:C10($StartA_ptr->{$Line_l})+"."+String:C10($StartB_ptr->{$Line_l})+"*"
	End for 
	
Else 
	
	$Changes_t:=""
	
End if 

$0:=$Changes_t


