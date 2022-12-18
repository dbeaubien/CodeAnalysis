//%attributes = {"invisible":true}
// MethodScan_LoadMethodNames
//
// Description
//   Loads all the method names into the array.
//
// Parameters
C_POINTER:C301($1; $methodNamesArrPtr)
C_POINTER:C301($2; $methodSafeNamesArrPtr)
// ----------------------------------------------------
// User name (OS): Dani Beaubien
// Date and time: 03/07/12, 07:19:27
//   Mod by: Dani Beaubien (09/29/2012) - Filter out Compiler_ methods if pref not set
//   Mod by: Dani Beaubien (10/03/2012) - Include methods for all objects
//   Mod by: Dani Beaubien (11/16/2012) - Task 2169
//   Mod by: Dani Beaubien (01/25/2013) - Address special characters
//   Mod: DB (11/27/2014) - Add arrays for tracking last modifcation date/time
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$methodNamesArrPtr:=$1
$methodSafeNamesArrPtr:=$2

OnErr_Install_Handler("OnErr_GENERIC")

ARRAY TEXT:C222($methodNamesArrPtr->; 0)
Methods_GetNames($methodNamesArrPtr)

ARRAY TEXT:C222($methodSafeNamesArrPtr->; Size of array:C274($methodNamesArrPtr->))
C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($methodNamesArrPtr->))
	$methodSafeNamesArrPtr->{$i}:=Replace string:C233($methodNamesArrPtr->{$i}; "<"; "%3C")
	$methodSafeNamesArrPtr->{$i}:=Replace string:C233($methodSafeNamesArrPtr->{$i}; ">"; "%3E")
	If ($methodSafeNamesArrPtr->{$i}#$methodNamesArrPtr->{$i})
		TRACE:C157
	End if 
End for 

If (OnErr_GetLastError#0)
	BEEP:C151
	ALERT:C41(OnErr_Message)
End if 
OnErr_Install_Handler