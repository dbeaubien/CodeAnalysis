//%attributes = {"invisible":true,"preemptive":"capable"}
// Method: OB_CopyObject
// $1: Object to copy from
// $2: Shared Object to copy to

// SOURCE: https://discuss.4d.com/t/getting-object-data-into-shared-object-or-shared-collection/10936/5
#DECLARE($from : Object; $to : Object)

var $nType; $counter : Integer

ARRAY TEXT:C222($arrNames; 0)

OB GET PROPERTY NAMES:C1232($from; $arrNames)
For ($counter; 1; Size of array:C274($arrNames))
	$nType:=OB Get type:C1230($from; $arrNames{$counter})
	Case of 
		: ($nType=Is object:K8:27)
			$to[$arrNames{$counter}]:=New shared object:C1526
			Use ($to[$arrNames{$counter}])
				OB_CopyObject($from[$arrNames{$counter}]; $to[$arrNames{$counter}])
			End use 
			
		: ($nType=Is collection:K8:32)
			$to[$arrNames{$counter}]:=New shared collection:C1527
			Use ($to[$arrNames{$counter}])
				OB_CopyCollection($from[$arrNames{$counter}]; $to[$arrNames{$counter}])
			End use 
			
		Else 
			$to[$arrNames{$counter}]:=$from[$arrNames{$counter}]
	End case 
End for 

