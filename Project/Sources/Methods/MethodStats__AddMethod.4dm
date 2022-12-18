//%attributes = {"invisible":true}
// MethodStats__AddMethod (methodPathToRefresh) : error
// MethodStats__AddMethod (text) : longint
// 
// DESCRIPTION
//   Adds the specified method (by path) to the 
//   internal arrays
//
C_TEXT:C284($1; $vt_methodPath)
C_LONGINT:C283($0; $errorNo)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/07/2014)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$vt_methodPath:=$1
$errorNo:=0

Logging_Method_START(Current method name:C684)
OnErr_Install_Handler("OnErr_GENERIC")
OnErr_ClearError

C_OBJECT:C1216(MethodStatsMasterObj)  // initalized by
MethodStats__Init

If (Undefined:C82(MethodStatsMasterObj[$vt_methodPath]))
	LogEvent_Write(Str_DateTimeStamp+"\tAdded \""+$vt_methodPath+"\"")
	MethodStats__NewDefaultObject($vt_methodPath; MethodStatsMasterObj)
End if 

$errorNo:=OnErr_GetLastError
OnErr_Install_Handler  // restore the error handler
OnErr_ClearError
Logging_Method_STOP(Current method name:C684)

$0:=$errorNo