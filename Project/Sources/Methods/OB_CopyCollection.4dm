//%attributes = {"invisible":true,"preemptive":"capable"}
// Method: OB_CopyCollection
// $1: Collection to copy from
// $2: Shared Collection to copy to

// SOURCE: https://discuss.4d.com/t/getting-object-data-into-shared-object-or-shared-collection/10936/5

C_COLLECTION:C1488($1; $2)
C_LONGINT:C283($nSize; $nCount; $nElement; $nType)

$nSize:=$1.length

$2.clear()  // clear out any previous elements

For ($nCount; 1; $nSize)
	$nElement:=$nCount-1
	$nType:=Value type:C1509($1[$nElement])
	Case of 
		: ($nType=Is object:K8:27)
			$2[$nElement]:=New shared object:C1526
			Use ($2[$nElement])
				OB_CopyObject($1[$nElement]; $2[$nElement])
			End use 
			
		: ($nType=Is collection:K8:32)
			$2[$nElement]:=New shared collection:C1527
			Use ($2[$nElement])
				OB_CopyCollection($1[$nElement]; $2[$nElement])
			End use 
			
		Else 
			$2[$nElement]:=$1[$nElement]
	End case 
End for 

