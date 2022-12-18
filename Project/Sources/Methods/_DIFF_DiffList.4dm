//%attributes = {"invisible":true}
// _DIFF_DiffList
// 
// DESCRIPTION
//   Scan the tables of which lines are inserted and deleted,
//   producing an edit script in forward order.
//
//   "CreateDiffs" from the original C# code.
//
C_POINTER:C301($1; $DataA_ptr)
C_POINTER:C301($2; $ModA_ptr)
C_POINTER:C301($3; $DataB_ptr)
C_POINTER:C301($4; $ModB_ptr)
C_POINTER:C301($5; $StartA_ptr)
C_POINTER:C301($6; $StartB_ptr)
C_POINTER:C301($7; $DeletedA_ptr)
C_POINTER:C301($8; $InsertedB_ptr)
// ----------------------------------------------------
// User name (OS): ddancy
// Date and time: 18/02/08, 13:33:23
// ----------------------------------------------------

$DataA_ptr:=$1
$ModA_ptr:=$2
$DataB_ptr:=$3
$ModB_ptr:=$4
$StartA_ptr:=$5
$StartB_ptr:=$6
$DeletedA_ptr:=$7
$InsertedB_ptr:=$8

C_LONGINT:C283($DataALength; $DataBLength)
C_LONGINT:C283($StartA; $StartB; $LineA; $LineB)

$DataALength:=Size of array:C274($DataA_ptr->)+1
$DataBLength:=Size of array:C274($DataB_ptr->)+1

$LineA:=0
$LineB:=0

Array_SetSize(0; $StartA_ptr)
Array_SetSize(0; $StartB_ptr)
Array_SetSize(0; $DeletedA_ptr)
Array_SetSize(0; $InsertedB_ptr)

C_BOOLEAN:C305($Equal)

While (($LineA<$DataALength) | ($LineB<$DataBLength))
	$Equal:=True:C214
	
	If (($LineA<$DataALength) & ($LineB<$DataBLength))
		
		If ((Not:C34($ModA_ptr->{$LineA})) & (Not:C34($ModB_ptr->{$LineB})))
			//lines are equal
			$LineA:=$LineA+1
			$LineB:=$LineB+1
			
		Else 
			$Equal:=False:C215
			
		End if 
		
	Else 
		$Equal:=False:C215
		
	End if 
	
	If (Not:C34($Equal))
		// maybe deleted and/or inserted lines
		$StartA:=$LineA
		$StartB:=$LineB
		
		C_BOOLEAN:C305($Continue)
		$Continue:=True:C214
		While ($Continue)
			If ($LineA<$DataALength)
				If (($LineB>=$DataBLength) | ($ModA_ptr->{$LineA}))
					$LineA:=$LineA+1
				Else 
					$Continue:=False:C215
				End if 
			Else 
				$Continue:=False:C215
			End if 
		End while 
		
		$Continue:=True:C214
		While ($Continue)
			If ($LineB<$DataBLength)
				If (($LineA>=$DataALength) | ($ModB_ptr->{$LineB}))
					$LineB:=$LineB+1
				Else 
					$Continue:=False:C215
				End if 
			Else 
				$Continue:=False:C215
			End if 
		End while 
		
		If (($StartA<$LineA) | ($StartB<$LineB))
			// store a new difference-item
			APPEND TO ARRAY:C911($StartA_ptr->; $StartA+1)
			APPEND TO ARRAY:C911($StartB_ptr->; $StartB+1)
			APPEND TO ARRAY:C911($DeletedA_ptr->; ($LineA-$StartA))
			APPEND TO ARRAY:C911($InsertedB_ptr->; ($LineB-$StartB))
		End if 
		
	End if 
	
End while 


