//%attributes = {"invisible":true,"shared":true}
// CA_GetMethodsCalledByMethod (methodName) : methodCalledObj
// CA_GetMethodsCalledByMethod (text) : object
// 
// DESCRIPTION
//   Returns, in an object, an array of methods that
//   call the specified method.
//
//   The object returned looks like {"calledByMethods":[]}
//
// NOTE: It is up to the caller to call MethodStats_RecalculateModified.
//
C_TEXT:C284($1; $methodName)
C_OBJECT:C1216($0; $methodsCalledObj)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (06/24/2016)
// ----------------------------------------------------

// PUBLIC METHOD 

ASSERT:C1129(Count parameters:C259=1)
$methodName:=$1

$methodsCalledObj:=Method_GetMethodsCalled($methodName)

$0:=$methodsCalledObj