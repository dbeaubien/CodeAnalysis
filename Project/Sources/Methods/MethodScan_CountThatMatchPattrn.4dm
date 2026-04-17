//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodScan_CountThatMatchPattrn (startsWith) : count
//
// DESCRIPTION
//   Returns the # of methods that start with the passed text.
//
#DECLARE($startsWith : Text)->$count : Integer
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$startsWith+="@"
$count:=0

ARRAY TEXT:C222($methodObjNames; 0)
Method_GetMethodObjNames(->$methodObjNames)

var $i : Integer
For ($i; 1; Size of array:C274($methodObjNames))
	If ($methodObjNames{$i}=$startsWith)
		$count:=$count+1
	End if 
End for 
