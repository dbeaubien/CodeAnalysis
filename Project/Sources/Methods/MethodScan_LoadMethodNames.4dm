//%attributes = {"invisible":true}
// MethodScan_LoadMethodNames
//
// Description
//   Loads all the method names into the array.
//
#DECLARE($methodNamesArrPtr : Pointer; $methodSafeNamesArrPtr : Pointer)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

OnErr_Install_Handler("OnErr_GENERIC")

ARRAY TEXT:C222($methodNamesArrPtr->; 0)
Methods_GetNames($methodNamesArrPtr)

ARRAY TEXT:C222($methodSafeNamesArrPtr->; Size of array:C274($methodNamesArrPtr->))
var $i : Integer
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