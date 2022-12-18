//%attributes = {"invisible":true,"shared":true}
// CA_GetMethodsCallingTheMethod (methodPath) : calledByObj
// CA_GetMethodsCallingTheMethod (text) : object
// 
// DESCRIPTION
//   Returns, in an object, an array of methods that
//   the specified method calls.
//
//   The object returned looks like {"methodsCalled":[]}
//
// NOTE: It is up to the caller to call MethodStats_RecalculateModified.
//
C_TEXT:C284($1; $methodPath)
C_OBJECT:C1216($0; $calledByMethodsObj)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (06/24/2016)
// ----------------------------------------------------

// PUBLIC METHOD 

ASSERT:C1129(Count parameters:C259=1)
$methodPath:=$1

$calledByMethodsObj:=Method_GetCalledByMethods($methodPath)

$0:=$calledByMethodsObj