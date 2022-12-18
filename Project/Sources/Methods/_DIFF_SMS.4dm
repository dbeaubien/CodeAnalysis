//%attributes = {"invisible":true}
// _DIFF_SMS
//
// DESCRIPTION
//   This method finds the Shortest Middle Snake.
//
C_POINTER:C301($1; $DataA_ptr)  // sequence A
C_LONGINT:C283($2; $LowerA)  // lower bound of the actual range in Data A
C_LONGINT:C283($3; $UpperA)  // upper bound of the actual range in Data A
C_POINTER:C301($4; $DataB_ptr)  // sequence B
C_LONGINT:C283($5; $LowerB)  // lower bound of the actual range in Data B
C_LONGINT:C283($6; $UpperB)  // upper bound of the actual range in Data B
C_POINTER:C301($7; $DownVector_ptr)  // a vector for the (0,0) to (x,y) search. Passed as a parameter for speed reasons.
C_POINTER:C301($8; $UpVector_ptr)  // >a vector for the (u,v) to (N,M) search. Passed as a parameter for speed reasons.
C_POINTER:C301($9; $X_ptr)  // Returns x
C_POINTER:C301($10; $Y_ptr)  // Returns y
// ----------------------------------------------------
// HISTORY
//   Created by: ddancy (18/02/2008)
// ----------------------------------------------------

$DataA_ptr:=$1
$LowerA:=$2
$UpperA:=$3
$DataB_ptr:=$4
$LowerB:=$5
$UpperB:=$6
$DownVector_ptr:=$7
$UpVector_ptr:=$8
$X_ptr:=$9
$Y_ptr:=$10

C_LONGINT:C283($SizeOfA; $SizeOfB)
$SizeOfA:=Size of array:C274($DataA_ptr->)+1
$SizeOfB:=Size of array:C274($DataB_ptr->)+1

C_LONGINT:C283($MAX)
$MAX:=$SizeOfA+$SizeOfB+1

C_LONGINT:C283($DownK; $UpK)
$DownK:=$LowerA-$LowerB  // the k-line to start the forward search
$UpK:=$UpperA-$UpperB  // the k-line to start the reverse search

C_LONGINT:C283($Delta)
C_BOOLEAN:C305($OddDelta)
$Delta:=($UpperA-$LowerA)-($UpperB-$LowerB)
$OddDelta:=($Delta%2#0)

// The vectors in the publication accepts negative indexes. the vectors implemented here are 0-based
// and are access using a specific offset: UpOffset UpVector and DownOffset for DownVektor
C_LONGINT:C283($DownOffset; $UpOffset)
$DownOffset:=$MAX-$DownK
$UpOffset:=$MAX-$UpK

C_LONGINT:C283($MaxD)
$MaxD:=(($UpperA-$LowerA+$UpperB-$LowerB)/2)+1

//_DBG_WriteLine("SMS: "+_PText("Search the box: A[%1-%2] to B[%3-%4]";String($LowerA);String($UpperA);String($LowerB);String($UpperB)))

// init vectors
$DownVector_ptr->{$DownOffset+$DownK+1}:=$LowerA
$UpVector_ptr->{$UpOffset+$UpK-1}:=$UpperA

C_LONGINT:C283($D; $k; $x; $y)

C_BOOLEAN:C305($Continue)
C_BOOLEAN:C305($Overlap)
$Overlap:=False:C215

For ($D; 0; $MaxD)
	
	If (Not:C34($Overlap))
		
		// Extend the forward path.
		For ($k; $DownK-$D; $DownK+$D; 2)
			//_DBG_WriteLine("SMS: "+"extend forward path "+String($k))
			
			// find the only or better starting point
			If ($k=($DownK-$D))
				$x:=$DownVector_ptr->{$DownOffset+$k+1}  //step down
			Else 
				$x:=$DownVector_ptr->{$DownOffset+$k-1}+1  //step right
				If (($k<($DownK+$D)) & ($DownVector_ptr->{$DownOffset+$k+1}>=$x))
					$x:=$DownVector_ptr->{$DownOffset+$k+1}  //step down instead
				End if 
			End if 
			
			$y:=$x-$k
			
			// find the end of the furthest reaching forward D-path in diagonal k.
			$Continue:=True:C214
			While ($Continue)
				If (($x<$UpperA) & ($y<$UpperB))
					If (($DataA_ptr->{$x}=$DataB_ptr->{$y}))
						$x:=$x+1
						$y:=$y+1
					Else 
						$Continue:=False:C215
					End if 
				Else 
					$Continue:=False:C215
				End if 
			End while 
			
			$DownVector_ptr->{$DownOffset+$k}:=$x
			
			// overlap ?
			If (($OddDelta) & (($UpK-$D)<$k) & ($k<($UpK+$D)))
				If ($UpVector_ptr->{$UpOffset+$k}<=$DownVector_ptr->{$DownOffset+$k})
					$X_ptr->:=$DownVector_ptr->{$DownOffset+$k}
					$Y_ptr->:=$DownVector_ptr->{$DownOffset+$k}-$k
					$Overlap:=True:C214
					
				End if 
				
			End if 
			
			If ($Overlap)
				$k:=$DownK+$D
			End if 
			
		End for 
		
	End if 
	
	If (Not:C34($Overlap))
		
		// Extend the reverse path.
		For ($k; $UpK-$D; $UpK+$D; 2)
			//_DBG_WriteLine("SMS: "+"extend reverse path "+String($k))
			
			// find the only or better starting point
			If ($k=($UpK+$D))
				$x:=$UpVector_ptr->{$UpOffset+$k-1}  //step up
			Else 
				$x:=$UpVector_ptr->{$UpOffset+$k+1}-1  //step left
				If (($k>($UpK-$D)) & ($UpVector_ptr->{$UpOffset+$k-1}<$x))
					$x:=$UpVector_ptr->{$UpOffset+$k-1}  //step up instead
				End if 
			End if 
			
			$y:=$x-$k
			
			$Continue:=True:C214
			While ($Continue)
				If (($x>$LowerA) & ($y>$LowerB))
					If (($DataA_ptr->{$x-1}=$DataB_ptr->{$y-1}))
						$x:=$x-1
						$y:=$y-1
					Else 
						$Continue:=False:C215
					End if 
				Else 
					$Continue:=False:C215
				End if 
			End while 
			
			$UpVector_ptr->{$UpOffset+$k}:=$x
			
			// overlap ?
			If ((Not:C34($OddDelta)) & (($DownK-$D)<=$k) & ($k<=($DownK+$D)))
				If ($UpVector_ptr->{$UpOffset+$k}<=$DownVector_ptr->{$DownOffset+$k})
					$X_ptr->:=$DownVector_ptr->{$DownOffset+$k}
					$Y_ptr->:=$DownVector_ptr->{$DownOffset+$k}-$k
					$Overlap:=True:C214
					
				End if 
				
			End if 
			
			If ($Overlap)
				$k:=$UpK+$D
			End if 
			
		End for 
		
	End if 
	
	If ($Overlap)
		$D:=$MaxD
	End if 
	
End for 

If (Not:C34($Overlap))
	//ALERT("No overlap")
End if 

