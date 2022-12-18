//%attributes = {"invisible":true}
// MethodStats__DeleteMethod (methodPathToRefresh) : error
// MethodStats__DeleteMethod (text) : longint
// 
// DESCRIPTION
//   Removes the specified method (by path) from the 
//   internal arrays
//
C_TEXT:C284($1; $methodPath)
C_LONGINT:C283($0; $errorNo)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/07/2014)
//   Mod by: Dani Beaubien (02/02/2021) - modernized
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$methodPath:=$1
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

$0:=$errorNo