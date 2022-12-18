//%attributes = {"invisible":true}
// Method_GetCalledByMethods (methodPath) : callersObj
// Method_GetCalledByMethods (text) : object
// 
// DESCRIPTION
//   Returns, in an object, an array of methods that
//   call the specified method.
//   The object returned looks like {"calledByMethods":[]}
//
C_TEXT:C284($1; $methodPath)
C_OBJECT:C1216($0; $calledByMethodsObj)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (06/24/2016)
//   Mod by: Dani Beaubien (02/04/2021) - refactored to use objects
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$methodPath:=$1
$calledByMethodsObj:=New object:C1471("calledByMethods"; New collection:C1472)  // start with a blank object

MethodStats__Init

If (MethodStatsMasterObj[$methodPath]#Null:C1517)
	$calledByMethodsObj.calledByMethods:=MethodStatsMasterObj[$methodPath].references.upstream_methods.copy()
End if 

$0:=$calledByMethodsObj