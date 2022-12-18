//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): ddancy
// Date and time: 22/04/08, 18:35:20
// ----------------------------------------------------
// Method: _DIFF_Synchronise
// Description
// Synchronise arrays A and B after doing a diff on them
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $A_ptr)
C_POINTER:C301($2; $B_ptr)
C_POINTER:C301($3; $StartA_ptr)
C_POINTER:C301($4; $StartB_ptr)
C_POINTER:C301($5; $DeletedA_ptr)
C_POINTER:C301($6; $InsertedB_ptr)
C_POINTER:C301($7; $LinesA_ptr)
C_POINTER:C301($8; $LinesB_ptr)
C_POINTER:C301($9; $Colours_ptr)
C_LONGINT:C283($10; $NormalColour_l)
C_LONGINT:C283($11; $InsertedColour_l)
C_LONGINT:C283($12; $DeletedColour_l)

$A_ptr:=$1
$B_ptr:=$2
$StartA_ptr:=$3
$StartB_ptr:=$4
$DeletedA_ptr:=$5
$InsertedB_ptr:=$6
$LinesA_ptr:=$7
$LinesB_ptr:=$8
If (Count parameters:C259>8)
	$Colours_ptr:=$9
End if 
If (Count parameters:C259>9)
	$NormalColour_l:=$10
Else 
	$NormalColour_l:=-255
End if 
If (Count parameters:C259>10)
	$InsertedColour_l:=$11
Else 
	$InsertedColour_l:=0x00E02D42  //0x00FF8800
End if 
If (Count parameters:C259>11)
	$DeletedColour_l:=$12
Else 
	$DeletedColour_l:=0x002702F5  //0xEE44
End if 

//************************************************
// Setup tasks
//************************************************

C_LONGINT:C283($Line_l; $LineCountA_l; $LineCountB_l)
$LineCountA_l:=Size of array:C274($A_ptr->)
$LineCountB_l:=Size of array:C274($B_ptr->)

If ($LineCountA_l>0)  //   Mod by: Dani Beaubien (10/01/2012) - add boundary check
	For ($Line_l; 0; $LineCountA_l; $LineCountA_l)
		Array_SetSize($Line_l; $LinesA_ptr)
	End for 
End if 

If ($LineCountB_l>0)  //   Mod by: Dani Beaubien (10/01/2012) - add boundary check
	For ($Line_l; 0; $LineCountB_l; $LineCountB_l)
		Array_SetSize($Line_l; $LinesB_ptr)
	End for 
Else 
	Array_SetSize(1; $LinesB_ptr)
End if 

// Add line #s
For ($Line_l; 1; $LineCountA_l)
	$LinesA_ptr->{$Line_l}:=$Line_l
End for 
For ($Line_l; 1; $LineCountB_l)
	$LinesB_ptr->{$Line_l}:=$Line_l
End for 

ARRAY LONGINT:C221($StartA_al; 0)
ARRAY LONGINT:C221($StartB_al; 0)
ARRAY LONGINT:C221($DeleteA_al; 0)
ARRAY LONGINT:C221($InsertB_al; 0)

COPY ARRAY:C226($StartA_ptr->; $StartA_al)
COPY ARRAY:C226($StartB_ptr->; $StartB_al)
COPY ARRAY:C226($DeletedA_ptr->; $DeleteA_al)
COPY ARRAY:C226($InsertedB_ptr->; $InsertB_al)

//************************************************
// Synchronise A and B
//************************************************

C_LONGINT:C283($Change_l; $Change1_l; $ChangeCount_l; $Line_l; $InsertA_l; $InsertB_l)
$ChangeCount_l:=Size of array:C274($StartA_al)

For ($Change_l; 1; $ChangeCount_l)
	If ($DeleteA_al{$Change_l}>0)
		$InsertB_l:=$StartA_al{$Change_l}
		INSERT IN ARRAY:C227($B_ptr->; $InsertB_l; $DeleteA_al{$Change_l})
		INSERT IN ARRAY:C227($LinesB_ptr->; $InsertB_l; $DeleteA_al{$Change_l})
		$StartA_al{$Change_l}:=$StartA_al{$Change_l}+$DeleteA_al{$Change_l}
	End if 
	
	If ($InsertB_al{$Change_l}>0)
		$InsertA_l:=$StartA_al{$Change_l}
		INSERT IN ARRAY:C227($A_ptr->; $InsertA_l; $InsertB_al{$Change_l})
		INSERT IN ARRAY:C227($LinesA_ptr->; $InsertA_l; $InsertB_al{$Change_l})
		$StartB_al{$Change_l}:=$StartB_al{$Change_l}+$InsertB_al{$Change_l}
	End if 
	
	// Adjust the remaining #s
	For ($Change1_l; $Change_l+1; $ChangeCount_l)
		$StartA_al{$Change1_l}:=$StartA_al{$Change1_l}+$InsertB_al{$Change_l}
		$StartB_al{$Change1_l}:=$StartB_al{$Change1_l}+$DeleteA_al{$Change_l}
	End for 
End for 

// Apply colours to the arrays
If (Not:C34(Is nil pointer:C315($Colours_ptr)))
	C_LONGINT:C283($LineCount_l)
	$LineCount_l:=Size of array:C274($A_ptr->)
	Array_SetSize($LineCount_l; $Colours_ptr)
	
	For ($Line_l; 1; $LineCount_l)
		$Colours_ptr->{$Line_l}:=$NormalColour_l  //default background colour
		
		If ($LinesA_ptr->{$Line_l}=0)  //it's a deletion
			$Colours_ptr->{$Line_l}:=$DeletedColour_l
		End if 
		
		If ($LinesB_ptr->{$Line_l}=0)  //it's an insert
			$Colours_ptr->{$Line_l}:=$InsertedColour_l
		End if 
		
	End for 
End if 

