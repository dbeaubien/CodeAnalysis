//%attributes = {"invisible":true}
// MethodStats__DeleteMethod (methodPathToRefresh) : error
// 
// DESCRIPTION
//   Removes the specified method (by path) from the 
//   internal arrays
//
#DECLARE($methodPath : Text)->$errorNo : Integer
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$errorNo:=0

MethodStats__Init
OnErr_Install_Handler("OnErr_GENERIC")
OnErr_ClearError

If (Not:C34(Undefined:C82(MethodStatsMasterObj[$methodPath])))
	OB REMOVE:C1226(MethodStatsMasterObj; $methodPath)
End if 

$errorNo:=OnErr_GetLastError
OnErr_ClearError
OnErr_Install_Handler
