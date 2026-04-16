//%attributes = {"invisible":true}
// Method_GetCalledByMethods (methodPath) : callersObj
// 
// DESCRIPTION
//   Returns, in an object, an array of methods that
//   call the specified method.
//   The object returned looks like {"calledByMethods":[]}
//
#DECLARE($methodPath : Text)->$calledByMethodsObj : Object
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

$calledByMethodsObj:=New object:C1471("calledByMethods"; New collection:C1472)  // start with a blank object

MethodStats__Init

If (MethodStatsMasterObj[$methodPath]#Null:C1517)
	$calledByMethodsObj.calledByMethods:=MethodStatsMasterObj[$methodPath].references.upstream_methods.copy()
End if 
