//%attributes = {"invisible":true}
// _DIFF_DiffCode
//
// DESCRIPTION
//   This function converts all textlines of the text into 
//   unique numbers for every unique textline so further 
//   work can work only with simple numbers.
//
#DECLARE($Array_ptr : Pointer\
; $DiffCode_ptr : Pointer\
; $vb_ignoreMultipleSpaces : Boolean\
; $vb_ignoreCase : Boolean)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 4; Count parameters:C259))
	var $Type_l : Integer
	$Type_l:=Type:C295($Array_ptr->)
	
	var $Hash_l; $HashCount_l : Integer
	
	var $Continue_b : Boolean
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
		
		var $vt_buffer : Text
		Case of 
			: ($Type_l=Is text:K8:3)
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
				var $Index_l : Integer
				For ($Hash_l; 0; $HashCount_l-1)
					$DiffCode_ptr->{$Hash_l}:=$Array_ptr->{$Hash_l+1}
				End for 
				
			Else 
				ALERT:C41("Type "+String:C10($Type_l)+" not supported for diff.")
				
		End case 
		
	End if 
	
End if 