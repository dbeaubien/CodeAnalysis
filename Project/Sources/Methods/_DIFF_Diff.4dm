//%attributes = {"invisible":true}
// _DIFF_Diff
//
// DESCRIPTION
//   Find the difference in 2 arrays of integers.
//   A array of Items containing the differences is returned.
//
#DECLARE($A_ptr : Pointer\
; $B_ptr : Pointer\
; $StartA_ptr : Pointer\
; $StartB_ptr : Pointer\
; $DeletedA_ptr : Pointer\
; $InsertedB_ptr : Pointer\
; $vb_ignoreMultipleSpaces : Boolean\
; $vb_ignoreCase : Boolean)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 6; 8; Count parameters:C259))
	ARRAY LONGINT:C221($DataA; 0)
	ARRAY LONGINT:C221($DataB; 0)
	
	var $DataA_ptr; $DataB_ptr : Pointer
	$DataA_ptr:=->$DataA
	$DataB_ptr:=->$DataB
	
	_DIFF_DiffCode($A_ptr; $DataA_ptr; $vb_ignoreMultipleSpaces; $vb_ignoreCase)  // Convert each text line to a number
	_DIFF_DiffCode($B_ptr; $DataB_ptr; $vb_ignoreMultipleSpaces; $vb_ignoreCase)  // Convert each text line to a number
	
	var $DataALength; $DataBLength : Integer
	$DataALength:=Size of array:C274($DataA_ptr->)+1
	$DataBLength:=Size of array:C274($DataB_ptr->)+1
	
	ARRAY BOOLEAN:C223($ModA; $DataALength-1)
	ARRAY BOOLEAN:C223($ModB; $DataBLength-1)
	
	var $MAX : Integer
	$MAX:=$DataALength+$DataBLength+1
	
	ARRAY LONGINT:C221($DownVector; (2*$MAX)+2)
	ARRAY LONGINT:C221($UpVector; (2*$MAX)+2)
	
	_DIFF_LCS($DataA_ptr; ->$ModA; 0; $DataALength; $DataB_ptr; ->$ModB; 0; $DataBLength; ->$DownVector; ->$UpVector)
	
	_DIFF_Optimise($DataA_ptr; ->$ModA)
	_DIFF_Optimise($DataB_ptr; ->$ModB)
	
	_DIFF_DiffList($DataA_ptr; ->$ModA; $DataB_ptr; ->$ModB; $StartA_ptr; $StartB_ptr; $DeletedA_ptr; $InsertedB_ptr)
	
End if 