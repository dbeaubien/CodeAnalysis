//%attributes = {"invisible":true}
// _DIFF_DiffList
// 
// DESCRIPTION
//   Scan the tables of which lines are inserted and deleted,
//   producing an edit script in forward order.
//
//   "CreateDiffs" from the original C# code.
//
#DECLARE($DataA_ptr : Pointer\
; $ModA_ptr : Pointer\
; $DataB_ptr : Pointer\
; $ModB_ptr : Pointer\
; $StartA_ptr : Pointer\
; $StartB_ptr : Pointer\
; $DeletedA_ptr : Pointer\
; $InsertedB_ptr : Pointer)
// ----------------------------------------------------

var $DataALength; $DataBLength : Integer
var $StartA; $StartB; $LineA; $LineB : Integer

$DataALength:=Size of array:C274($DataA_ptr->)+1
$DataBLength:=Size of array:C274($DataB_ptr->)+1

$LineA:=0
$LineB:=0

Array_SetSize(0; $StartA_ptr)
Array_SetSize(0; $StartB_ptr)
Array_SetSize(0; $DeletedA_ptr)
Array_SetSize(0; $InsertedB_ptr)

var $Equal : Boolean

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
		
		var $Continue : Boolean
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
