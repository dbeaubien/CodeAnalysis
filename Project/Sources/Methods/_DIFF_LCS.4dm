//%attributes = {"invisible":true}
// _DIFF_LCS
//
// DESCRIPTION
//   This is the divide-and-conquer implementation of the longest common-subsequence algorithm
//
C_POINTER:C301($1; $DataA_ptr)  // sequence A
C_POINTER:C301($2; $ModA_ptr)
C_LONGINT:C283($3; $LowerA)  // lower bound of the actual range in DataA
C_LONGINT:C283($4; $UpperA)  // upper bound of the actual range in DataA
C_POINTER:C301($5; $DataB_ptr)  // sequence B
C_POINTER:C301($6; $ModB_ptr)
C_LONGINT:C283($7; $LowerB)  // lower bound of the actual range in DataB
C_LONGINT:C283($8; $UpperB)  // upper bound of the actual range in DataB 
C_POINTER:C301($9; $DownVector_ptr)  // a vector for the (0,0) to (x,y) search. Passed as a parameter for speed reasons.
C_POINTER:C301($10; $UpVector_ptr)  // a vector for the (u,v) to (N,M) search. Passed as a parameter for speed reasons.
// ----------------------------------------------------
// User name (OS): ddancy
// Date and time: 18/02/08, 12:18:07
// ----------------------------------------------------

$DataA_ptr:=$1
$ModA_ptr:=$2
$LowerA:=$3
$UpperA:=$4
$DataB_ptr:=$5
$ModB_ptr:=$6
$LowerB:=$7
$UpperB:=$8
$DownVector_ptr:=$9
$UpVector_ptr:=$10

//_DBG_WriteLine("LCS: "+_PText("Analyse the box: A[%1-%2] to B[%3-%4]";String($LowerA);String($UpperA);String($LowerB);String($UpperB)))

// Fast walkthrough equal lines at the start
C_BOOLEAN:C305($Continue)
$Continue:=True:C214
While ($Continue)
	If (($LowerA<$UpperA) & ($LowerB<$UpperB))
		If (($DataA_ptr->{$LowerA}=$DataB_ptr->{$LowerB}))
			$LowerA:=$LowerA+1
			$LowerB:=$LowerB+1
		Else 
			$Continue:=False:C215
		End if 
	Else 
		$Continue:=False:C215
	End if 
End while 

// Fast walkthrough equal lines at the end
$Continue:=True:C214
While ($Continue)
	If (($LowerA<$UpperA) & ($LowerB<$UpperB))
		If (($DataA_ptr->{$UpperA-1}=$DataB_ptr->{$UpperB-1}))
			$UpperA:=$UpperA-1
			$UpperB:=$UpperB-1
		Else 
			$Continue:=False:C215
		End if 
	Else 
		$Continue:=False:C215
	End if 
End while 

Case of 
	: ($LowerA=$UpperA)  // B has more lines than A does, mark them as modified
		While ($LowerB<$UpperB)
			$ModB_ptr->{$LowerB}:=True:C214
			$LowerB:=$LowerB+1
		End while 
		
	: ($LowerB=$UpperB)  // A has more lines than B does, mark them as modified
		While ($LowerA<$UpperA)
			$ModA_ptr->{$LowerA}:=True:C214
			$LowerA:=$LowerA+1
		End while 
		
	Else 
		
		C_LONGINT:C283($X; $Y)
		
		// Find the middle snake and length of an optimal path for A and B
		_DIFF_SMS($DataA_ptr; $LowerA; $UpperA; $DataB_ptr; $LowerB; $UpperB; $DownVector_ptr; $UpVector_ptr; ->$X; ->$Y)
		//_DBG_WriteLine("MiddleSnakeData: "+_PText("%1,%2";String($X);String($Y)))
		
		// The path is from LowerX to (x,y) and (x,y) to UpperX
		_DIFF_LCS($DataA_ptr; $ModA_ptr; $LowerA; $X; $DataB_ptr; $ModB_ptr; $LowerB; $Y; $DownVector_ptr; $UpVector_ptr)
		_DIFF_LCS($DataA_ptr; $ModA_ptr; $X; $UpperA; $DataB_ptr; $ModB_ptr; $Y; $UpperB; $DownVector_ptr; $UpVector_ptr)
End case 

