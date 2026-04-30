//%attributes = {"invisible":true,"shared":true}
// CA_GetMethodsCalledByMethod (methodName) : methodCalledObj
// 
// DESCRIPTION
//   Returns, in an object, an array of methods that
//   call the specified method.
//
//   The object returned looks like {"calledByMethods":[]}
//
// NOTE: It is up to the caller to call MethodStats_RecalculateModified.
//
#DECLARE($methodName : Text)->$methodsCalledObj : Object
// ----------------------------------------------------

// PUBLIC METHOD 

ASSERT:C1129(Count parameters:C259=1)

$methodsCalledObj:=Method_GetMethodsCalled($methodName)