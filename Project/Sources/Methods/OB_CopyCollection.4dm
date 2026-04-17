//%attributes = {"invisible":true,"preemptive":"capable"}
// Method: OB_CopyCollection
// $1: Collection to copy from
// $2: Shared Collection to copy to

// SOURCE: https://discuss.4d.com/t/getting-object-data-into-shared-object-or-shared-collection/10936/5
#DECLARE($from : Collection; $to : Collection)

var $nSize; $nCount; $nElement; $nType : Integer

$nSize:=$from.length

$to.clear()  // clear out any previous elements

For ($nCount; 1; $nSize)
	$nElement:=$nCount-1
	$nType:=Value type:C1509($from[$nElement])
	Case of 
		: ($nType=Is object:K8:27)
			$to[$nElement]:=New shared object:C1526
			Use ($to[$nElement])
				OB_CopyObject($from[$nElement]; $to[$nElement])
			End use 
			
		: ($nType=Is collection:K8:32)
			$to[$nElement]:=New shared collection:C1527
			Use ($to[$nElement])
				OB_CopyCollection($from[$nElement]; $to[$nElement])
			End use 
			
		Else 
			$to[$nElement]:=$from[$nElement]
	End case 
End for 

