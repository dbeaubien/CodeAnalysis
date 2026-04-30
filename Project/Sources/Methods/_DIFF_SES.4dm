//%attributes = {"invisible":true}
// _DIFF_SES
//
#DECLARE($A_ptr : Pointer; $B_ptr : Pointer; $SMS_ptr : Pointer)->$SES : Integer
// ----------------------------------------------------
$SES:=-1

var $NoErrors_b : Boolean
$NoErrors_b:=True:C214

var $Type_l : Integer
$Type_l:=Type:C295($A_ptr->)
If ($Type_l#Type:C295($B_ptr->))
	ALERT:C41("Incompatible variable types for DIFF comparison.")
	$NoErrors_b:=False:C215
End if 

var $A1_ptr : Pointer
var $B1_ptr : Pointer

If ($NoErrors_b)
	
	If ($Type_l=Is text:K8:3)
		ARRAY TEXT:C222($TempA_at; 0)
		ARRAY TEXT:C222($TempB_at; 0)
		
		var $x1; $y1 : Integer
		
		For ($x1; 1; Length:C16($A_ptr->))
			APPEND TO ARRAY:C911($TempA_at; $A_ptr->[[$x1]])
		End for 
		
		For ($y1; 1; Length:C16($B_ptr->))
			APPEND TO ARRAY:C911($TempB_at; $B_ptr->[[$y1]])
		End for 
		
		$A_ptr:=->$TempA_at
		$B_ptr:=->$TempB_at
		
		$Type_l:=Text array:K8:16
	End if 
	
	var $OptimisedCopy_b : Boolean
	$OptimisedCopy_b:=True:C214
	
	Case of 
		: ($Type_l=Integer array:K8:18)
			ARRAY INTEGER:C220($A1_ai; 0)
			ARRAY INTEGER:C220($B1_ai; 0)
			$A1_ptr:=->$A1_ai
			$B1_ptr:=->$B1_ai
			
		: ($Type_l=LongInt array:K8:19)
			ARRAY LONGINT:C221($A1_al; 0)
			ARRAY LONGINT:C221($B1_al; 0)
			$A1_ptr:=->$A1_al
			$B1_ptr:=->$B1_al
			
		: ($Type_l=String array:K8:15)
			ARRAY TEXT:C222($A1_as; 0)
			ARRAY TEXT:C222($B1_as; 0)
			$A1_ptr:=->$A1_as
			$B1_ptr:=->$B1_as
			$OptimisedCopy_b:=False:C215
			
		: ($Type_l=Text array:K8:16)
			ARRAY TEXT:C222($A1_at; 0)
			ARRAY TEXT:C222($B1_at; 0)
			$A1_ptr:=->$A1_at
			$B1_ptr:=->$B1_at
			
		Else 
			ALERT:C41("Unsupported array type.")
			$NoErrors_b:=False:C215
			
	End case 
	
	If ($NoErrors_b)
		
		If ($OptimisedCopy_b)
			
			COPY ARRAY:C226($A_ptr->; $A1_ptr->)
			COPY ARRAY:C226($B_ptr->; $B1_ptr->)
			
		Else 
			var $Element_l; $ElementCount_l : Integer
			
			$ElementCount_l:=Size of array:C274($A_ptr->)
			
			Array_SetSize($ElementCount_l; $A1_ptr)
			For ($Element_l; 1; $ElementCount_l)
				$A1_ptr->{$Element_l}:=$A_ptr->{$Element_l}
			End for 
			
			$ElementCount_l:=Size of array:C274($B_ptr->)
			
			Array_SetSize($ElementCount_l; $B1_ptr)
			For ($Element_l; 1; $ElementCount_l)
				$B1_ptr->{$Element_l}:=$B_ptr->{$Element_l}
			End for 
			
		End if 
		
		Array_SetSize(0; $SMS_ptr)
		
		var $N; $M; $MAX; $D; $k; $k1; $x; $y : Integer
		$N:=Size of array:C274($A1_ptr->)
		$M:=Size of array:C274($B1_ptr->)
		$MAX:=$N+$M
		
		ARRAY LONGINT:C221($V; (2*$MAX)+1)  //index from -MAX .. 0 .. MAX
		
		$V{$N+$M+1}:=0
		
		var $Continue : Boolean
		
		For ($D; 0; $MAX)
			
			For ($k; -$D; $D; 2)
				$k1:=$k+$N+$M+1
				
				If (($k=-$D) | (($k#$D) & ($V{$k1-1}<$V{$k1+1})))
					$x:=$V{$k1+1}
				Else 
					$x:=$V{$k1-1}+1
				End if 
				
				$y:=$x-$k
				
				$Continue:=True:C214
				While ($Continue)
					If (($x<$N) & ($y<$M))
						If (($A1_ptr->{$x+1}=$B1_ptr->{$y+1}))
							$x:=$x+1
							$y:=$y+1
						Else 
							$Continue:=False:C215
						End if 
					Else 
						$Continue:=False:C215
					End if 
				End while 
				
				$V{$k1}:=$x
				
				If (($x>=$N) & ($y>=$M))
					$SES:=$D
					$k:=$D+1  //stop inner loop
					$D:=$MAX+1  //stop outer loop
				End if 
				
			End for 
			
		End for 
		
		If ($SES>0)  //there is a solution
			$x:=$N
			$y:=$M
		End if 
		
	End if 
	
End if 
