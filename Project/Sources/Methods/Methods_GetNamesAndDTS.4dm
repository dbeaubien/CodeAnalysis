//%attributes = {"invisible":true}
// Methods_GetNamesAndDTS (methodNamesArrPtr; methodModDTSArrPtr)
// Methods_GetNamesAndDTS (pointer; pointer)
// 
// DESCRIPTION
//   Loads the method names and calcualtes the last time
//   the method was modified as a datetime longint.
//   Method Preferences are recognized.
//
C_POINTER:C301($1; $ap_methodNamesArrPtr)
C_POINTER:C301($2; $ap_methodModDTSArrPtr)
// ----------------------------------------------------
// CALLED BY
//   MethodScan_LoadMethodNames
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/27/2014)
// ----------------------------------------------------

Logging_Method_START(Current method name:C684)
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$ap_methodNamesArrPtr:=$1
	$ap_methodModDTSArrPtr:=$2
	
	Methods_GetNames($ap_methodNamesArrPtr)
	
	//   Mod: DB (11/27/2014) - Get the last mod date & time
	ARRAY DATE:C224($ad_methodModDate; 0)
	ARRAY LONGINT:C221($ah_methodModTime; 0)
	METHOD GET MODIFICATION DATE:C1170($ap_methodNamesArrPtr->; $ad_methodModDate; $ah_methodModTime; *)
	Array_SetSize(Size of array:C274($ap_methodNamesArrPtr->); $ap_methodModDTSArrPtr)
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($ap_methodNamesArrPtr->))
		$ap_methodModDTSArrPtr->{$i}:=TS_FromDateTime($ad_methodModDate{$i}; $ah_methodModTime{$i})
	End for 
	
	SORT ARRAY:C229($ap_methodNamesArrPtr->; $ap_methodModDTSArrPtr->; >)
End if   // ASSERT
Logging_Method_STOP(Current method name:C684)
