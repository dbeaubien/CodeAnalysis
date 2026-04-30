//%attributes = {"invisible":true,"shared":true}
// CA_GetMethodsCallingTheMethod (methodPath) : calledByObj
// 
// DESCRIPTION
//   Returns, in an object, an array of methods that
//   the specified method calls.
//
//   The object returned looks like {"methodsCalled":[]}
//
// NOTE: It is up to the caller to call MethodStats_RecalculateModified.
//
#DECLARE($methodPath : Text)->$calledByMethodsObj : Object
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

// PUBLIC METHOD 

$calledByMethodsObj:=Method_GetCalledByMethods($methodPath)

return $calledByMethodsObj