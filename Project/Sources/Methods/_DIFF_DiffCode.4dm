//%attributes = {"invisible":true}
// _DIFF_DiffCode
//
// DESCRIPTION
//   This function converts all textlines of the text into 
//   unique numbers for every unique textline so further 
//   work can work only with simple numbers.
//
C_POINTER:C301($1; $Array_ptr)
C_POINTER:C301($2; $DiffCode_ptr)
C_BOOLEAN:C305($3; $vb_ignoreMultipleSpaces)
C_BOOLEAN:C305($4; $vb_ignoreCase)
// ----------------------------------------------------
// HISTORY
//   Created by: ddancy (02/18/2008)
//   Mod by: Dani Beaubien (10/25/2012) - Added support for $vb_ignoreMultipleSpaces and $vb_ignoreCase
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 4; Count parameters:C259))
	$Array_ptr:=$1
	$DiffCode_ptr:=$2
	$vb_ignoreMultipleSpaces:=$3
	$vb_ignoreCase:=$4
	
	C_LONGINT:C283($Type_l)
	$Type_l:=Type:C295($Array_ptr->)
	
	C_LONGINT:C283($Hash_l; $HashCount_l)
	
	C_BOOLEAN:C305($Continue_b)
	$Continue_b:=True:C214
	
	Case of 
		: (_PTR_IsArray($Array_ptr))
			$HashCount_l:=Size of array:C274($Array_ptr->)
			
		: ($Type_l=Is text:K8:3)
			$HashCount_l:=Length:C16($Array_ptr->)
			
		Else 
			ALERT:C41("Type "+String:C10($Type_l)+" not supported for diff.")
			$Continue_b:=False:C215
			
	End case 
	
	If ($Continue_b)
		Array_SetSize($HashCount_l-1; $DiffCode_ptr)  //make this a 0-indexed array
		
		Case of 
			: ($Type_l=Is text:K8:3)
				C_TEXT:C284($vt_buffer)
				$vt_buffer:=$Array_ptr->
				If ($vb_ignoreCase)  // Added by: Dani Beaubien (10/25/2012)
					$vt_buffer:=Lowercase:C14($vt_buffer)
				End if 
				If ($vb_ignoreMultipleSpaces)  // Added by: Dani Beaubien (10/25/2012)
					$vt_buffer:=Replace string:C233($vt_buffer; "  "; " ")
					$vt_buffer:=Replace string:C233($vt_buffer; "  "; " ")
					$vt_buffer:=Replace string:C233($vt_buffer; "  "; " ")
				End if 
				
				For ($Hash_l; 0; $HashCount_l-1)
					$DiffCode_ptr->{$Hash_l}:=HASH_HashTextSDBM($vt_buffer[[$Hash_l+1]])
				End for 
				
			: ($Type_l=Text array:K8:16)
				For ($Hash_l; 0; $HashCount_l-1)
					C_TEXT:C284($vt_buffer)
					$vt_buffer:=$Array_ptr->{$Hash_l+1}
					If ($vb_ignoreCase)  // Added by: Dani Beaubien (10/25/2012)
						$vt_buffer:=Lowercase:C14($vt_buffer)
					End if 
					If ($vb_ignoreMultipleSpaces)  // Added by: Dani Beaubien (10/25/2012)
						$vt_buffer:=Replace string:C233($vt_buffer; "  "; " ")
						$vt_buffer:=Replace string:C233($vt_buffer; "  "; " ")
						$vt_buffer:=Replace string:C233($vt_buffer; "  "; " ")
					End if 
					
					$DiffCode_ptr->{$Hash_l}:=HASH_HashTextSDBM($vt_buffer)
				End for 
				
				
			: (($Type_l=Integer array:K8:18) | ($Type_l=LongInt array:K8:19))
				C_LONGINT:C283($Index_l)
				For ($Hash_l; 0; $HashCount_l-1)
					$DiffCode_ptr->{$Hash_l}:=$Array_ptr->{$Hash_l+1}
				End for 
				
			Else 
				ALERT:C41("Type "+String:C10($Type_l)+" not supported for diff.")
				
		End case 
		
	End if 
	
End if   // ASSERT