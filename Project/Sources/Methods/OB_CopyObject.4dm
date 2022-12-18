//%attributes = {"invisible":true,"preemptive":"capable"}
// Method: OB_CopyObject
// $1: Object to copy from
// $2: Shared Object to copy to

// SOURCE: https://discuss.4d.com/t/getting-object-data-into-shared-object-or-shared-collection/10936/5

C_OBJECT:C1216($1; $2)
C_LONGINT:C283($nType; $counter)

ARRAY TEXT:C222($arrNames; 0)

OB GET PROPERTY NAMES:C1232($1; $arrNames)
For ($counter; 1; Size of array:C274($arrNames))
	$nType:=OB Get type:C1230($1; $arrNames{$counter})
	Case of 
		: ($nType=Is object:K8:27)
			$2[$arrNames{$counter}]:=New shared object:C1526
			Use ($2[$arrNames{$counter}])
				OB_CopyObject($1[$arrNames{$counter}]; $2[$arrNames{$counter}])
			End use 
			
		: ($nType=Is collection:K8:32)
			$2[$arrNames{$counter}]:=New shared collection:C1527
			Use ($2[$arrNames{$counter}])
				OB_CopyCollection($1[$arrNames{$counter}]; $2[$arrNames{$counter}])
			End use 
			
		Else 
			$2[$arrNames{$counter}]:=$1[$arrNames{$counter}]
	End case 
End for 

