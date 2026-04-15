//%attributes = {"invisible":true}
// _DIFF_SMS
//
// DESCRIPTION
//   This method finds the Shortest Middle Snake.
//
#DECLARE($DataA_ptr : Pointer\
; $LowerA : Integer; $UpperA : Integer\
; $DataB_ptr : Pointer\
; $LowerB : Integer; $UpperB : Integer\
; $DownVector_ptr : Pointer\
; $UpVector_ptr : Pointer\
; $X_ptr : Pointer; $Y_ptr : Pointer)
//var $1; $DataA_ptr : Pointer  // sequence A
//var $2; $LowerA : Integer  // lower bound of the actual range in Data A
//var $3; $UpperA : Integer  // upper bound of the actual range in Data A
//var $4; $DataB_ptr : Pointer  // sequence B
//var $5; $LowerB : Integer  // lower bound of the actual range in Data B
//var $6; $UpperB : Integer  // upper bound of the actual range in Data B
//var $7; $DownVector_ptr : Pointer  // a vector for the (0,0) to (x,y) search. Passed as a parameter for speed reasons.
//var $8; $UpVector_ptr : Pointer  // >a vector for the (u,v) to (N,M) search. Passed as a parameter for speed reasons.
//var $9; $X_ptr : Pointer  // Returns x
//var $10; $Y_ptr : Pointer  // Returns y
// ----------------------------------------------------

var $SizeOfA; $SizeOfB : Integer
$SizeOfA:=Size of array:C274($DataA_ptr->)+1
$SizeOfB:=Size of array:C274($DataB_ptr->)+1

var $MAX : Integer
$MAX:=$SizeOfA+$SizeOfB+1

var $DownK; $UpK : Integer
$DownK:=$LowerA-$LowerB  // the k-line to start the forward search
$UpK:=$UpperA-$UpperB  // the k-line to start the reverse search

var $Delta : Integer
var $OddDelta : Boolean
$Delta:=($UpperA-$LowerA)-($UpperB-$LowerB)
$OddDelta:=($Delta%2#0)

// The vectors in the publication accepts negative indexes. the vectors implemented here are 0-based
// and are access using a specific offset: UpOffset UpVector and DownOffset for DownVektor
var $DownOffset; $UpOffset : Integer
$DownOffset:=$MAX-$DownK
$UpOffset:=$MAX-$UpK

var $MaxD : Integer
$MaxD:=(($UpperA-$LowerA+$UpperB-$LowerB)/2)+1

//_DBG_WriteLine("SMS: "+_PText("Search the box: A[%1-%2] to B[%3-%4]";String($LowerA);String($UpperA);String($LowerB);String($UpperB)))

// init vectors
$DownVector_ptr->{$DownOffset+$DownK+1}:=$LowerA
$UpVector_ptr->{$UpOffset+$UpK-1}:=$UpperA

var $D; $k; $x; $y : Integer

var $Continue : Boolean
var $Overlap : Boolean
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
