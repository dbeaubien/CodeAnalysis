//%attributes = {"invisible":true}
// Method_GetMethodsCalled (methodPath) : methodCalledObj
// 
// DESCRIPTION
//   Returns, in an object, an array of methods that
//   the specified method calls.
//   The object returned looks like {"methodsCalled":[]}
//
#DECLARE($methodPath : Text)->$methodsCalledObj : Object
// ----------------------------------------------------

ASSERT:C1129(Count parameters:C259=1)
$methodsCalledObj:=New object:C1471("methodsCalled"; New collection:C1472)  // start with a blank object

MethodStats__Init

If (MethodStatsMasterObj[$methodPath]#Null:C1517)
	$methodsCalledObj.methodsCalled:=MethodStatsMasterObj[$methodPath].references.downstream_methods.copy()
End if 
