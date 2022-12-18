//%attributes = {"invisible":true}
// _DIFF_Diff
//
// DESCRIPTION
//   Find the difference in 2 arrays of integers.
//   A array of Items containing the differences is returned.
//
C_POINTER:C301($1; $A_ptr)  //first array of texts
C_POINTER:C301($2; $B_ptr)  //second array of texts
C_POINTER:C301($3; $StartA_ptr)
C_POINTER:C301($4; $StartB_ptr)
C_POINTER:C301($5; $DeletedA_ptr)
C_POINTER:C301($6; $InsertedB_ptr)
C_BOOLEAN:C305($7; $vb_ignoreMultipleSpaces)
C_BOOLEAN:C305($8; $vb_ignoreCase)
// ----------------------------------------------------
// HISTORY
//   Created by: ddancy (02/15/2008)
//   Mod by: Dani Beaubien (10/25/2012) - Added support for $vb_ignoreMultipleSpaces and $vb_ignoreCase
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 6; 8; Count parameters:C259))
	$A_ptr:=$1
	$B_ptr:=$2
	$StartA_ptr:=$3
	$StartB_ptr:=$4
	$DeletedA_ptr:=$5
	$InsertedB_ptr:=$6
	If (Count parameters:C259>=7)
		$vb_ignoreMultipleSpaces:=$7
	Else 
		$vb_ignoreMultipleSpaces:=False:C215
	End if 
	If (Count parameters:C259>=8)
		$vb_ignoreCase:=$8
	Else 
		$vb_ignoreCase:=False:C215
	End if 
	
	ARRAY LONGINT:C221($DataA; 0)
	ARRAY LONGINT:C221($DataB; 0)
	
	C_POINTER:C301($DataA_ptr; $DataB_ptr)
	$DataA_ptr:=->$DataA
	$DataB_ptr:=->$DataB
	
	_DIFF_DiffCode($A_ptr; $DataA_ptr; $vb_ignoreMultipleSpaces; $vb_ignoreCase)  // Convert each text line to a number
	_DIFF_DiffCode($B_ptr; $DataB_ptr; $vb_ignoreMultipleSpaces; $vb_ignoreCase)  // Convert each text line to a number
	
	C_LONGINT:C283($DataALength; $DataBLength)
	$DataALength:=Size of array:C274($DataA_ptr->)+1
	$DataBLength:=Size of array:C274($DataB_ptr->)+1
	
	ARRAY BOOLEAN:C223($ModA; $DataALength-1)
	ARRAY BOOLEAN:C223($ModB; $DataBLength-1)
	
	C_LONGINT:C283($MAX)
	$MAX:=$DataALength+$DataBLength+1
	
	ARRAY LONGINT:C221($DownVector; (2*$MAX)+2)
	ARRAY LONGINT:C221($UpVector; (2*$MAX)+2)
	
	_DIFF_LCS($DataA_ptr; ->$ModA; 0; $DataALength; $DataB_ptr; ->$ModB; 0; $DataBLength; ->$DownVector; ->$UpVector)
	
	_DIFF_Optimise($DataA_ptr; ->$ModA)
	_DIFF_Optimise($DataB_ptr; ->$ModB)
	
	_DIFF_DiffList($DataA_ptr; ->$ModA; $DataB_ptr; ->$ModB; $StartA_ptr; $StartB_ptr; $DeletedA_ptr; $InsertedB_ptr)
	
End if   // ASSERT