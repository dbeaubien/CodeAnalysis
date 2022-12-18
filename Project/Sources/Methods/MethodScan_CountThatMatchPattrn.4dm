//%attributes = {"invisible":true,"preemptive":"capable"}
// MethodScan_CountThatMatchPattrn (startsWith) : count
// MethodScan_CountThatMatchPattrn (text) : longint
//
// DESCRIPTION
//   Returns the # of methods that start with the passed text.
//
C_TEXT:C284($1; $startsWith)
C_LONGINT:C283($0; $count)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/07/2012)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$startsWith:=$1+"@"
$count:=0

ARRAY TEXT:C222($methodObjNames; 0)
Method_GetMethodObjNames(->$methodObjNames)

C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($methodObjNames))
	If ($methodObjNames{$i}=$startsWith)
		$count:=$count+1
	End if 
End for 

$0:=$count