//%attributes = {"invisible":true}
// _DIFF_Optimise
//
// DESCRIPTION
//   If a sequence of modified lines starts with a line that contains the same content
//   as the line that appends the changes, the difference sequence is modified so that the
//   appended line and not the starting line is marked as modified.
//   This leads to more readable diff sequences when comparing text files.
//
#DECLARE($Data_ptr : Pointer; $Mod_ptr : Pointer)
// ----------------------------------------------------

var $Start; $End; $DataLength : Integer
$Start:=0
$DataLength:=Size of array:C274($Data_ptr->)+1

var $Continue : Boolean
While ($Start<$DataLength)
	$Continue:=True:C214
	
	While ($Continue)
		If ($Start<$DataLength)
			If ($Mod_ptr->{$Start}=False:C215)
				$Start:=$Start+1
			Else 
				$Continue:=False:C215
			End if 
		Else 
			$Continue:=False:C215
		End if 
	End while 
	
	$End:=$Start
	$Continue:=True:C214
	While ($Continue)
		If ($End<$DataLength)
			If ($Mod_ptr->{$End}=True:C214)
				$End:=$End+1
			Else 
				$Continue:=False:C215
			End if 
		Else 
			$Continue:=False:C215
		End if 
	End while 
	
	If ($End<$DataLength)
		If ($Data_ptr->{$Start}=$Data_ptr->{$End})
			$Mod_ptr->{$Start}:=False:C215
			$Mod_ptr->{$End}:=True:C214
		Else 
			$Start:=$End
		End if 
	Else 
		$Start:=$End
	End if 
	
End while 


