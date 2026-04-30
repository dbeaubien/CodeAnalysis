//%attributes = {"invisible":true}
// MethodStats__AddMethod (methodPathToRefresh) : error
// 
// DESCRIPTION
//   Adds the specified method (by path) to the 
//   internal arrays
//
#DECLARE($vt_methodPath : Text)->$errorNo : Integer
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$errorNo:=0

Logging_Method_START(Current method name:C684)
OnErr_Install_Handler("OnErr_GENERIC")
OnErr_ClearError

var MethodStatsMasterObj : Object  // initalized by
MethodStats__Init

If (Undefined:C82(MethodStatsMasterObj[$vt_methodPath]))
	LogEvent_Write(Str_DateTimeStamp+"\tAdded \""+$vt_methodPath+"\"")
	MethodStats__NewDefaultObject($vt_methodPath; MethodStatsMasterObj)
End if 

$errorNo:=OnErr_GetLastError
OnErr_Install_Handler  // restore the error handler
OnErr_ClearError
Logging_Method_STOP(Current method name:C684)