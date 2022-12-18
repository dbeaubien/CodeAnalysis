//%attributes = {"invisible":true}
// Method_GetMethodsCalled (methodPath) : methodCalledObj
// Method_GetMethodsCalled (text) : object
// 
// DESCRIPTION
//   Returns, in an object, an array of methods that
//   the specified method calls.
//   The object returned looks like {"methodsCalled":[]}
//
C_TEXT:C284($1; $methodPath)
C_OBJECT:C1216($0; $methodsCalledObj)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (06/24/2016)
//   Mod by: Dani Beaubien (02/04/2021) - refactored to use objects
// ----------------------------------------------------

ASSERT:C1129(Count parameters:C259=1)
$methodPath:=$1
$methodsCalledObj:=New object:C1471("methodsCalled"; New collection:C1472)  // start with a blank object

MethodStats__Init

If (MethodStatsMasterObj[$methodPath]#Null:C1517)
	$methodsCalledObj.methodsCalled:=MethodStatsMasterObj[$methodPath].references.downstream_methods.copy()
End if 

$0:=$methodsCalledObj