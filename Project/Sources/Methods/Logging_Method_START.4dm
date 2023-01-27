//%attributes = {"invisible":true,"preemptive":"capable"}
// Logging_Method_START (methodName {;optionalText})
// Logging_Method_START (text {;text})
// 
// DESCRIPTION
//   Used to log entering a method.
//
C_TEXT:C284($1)  // method name
C_TEXT:C284($2)  // OPTIONAL; optional text
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/23/07)
//   Mod: DB (10/29/2010) - Track start time
//   Mod: DB (11/22/2010) - support performance tracking switch
//   Mod: DB (01/20/2011) - Method stack always being tracked
// ----------------------------------------------------

Logging_Method__init

C_BOOLEAN:C305(_LOGMETHOD_exists)
_LOGMETHOD_exists:=True:C214

C_LONGINT:C283($vl_msStart)
$vl_msStart:=Milliseconds:C459

// Add our method to the call stack
APPEND TO ARRAY:C911(_LOGMETHOD_CallingStack; $1)
If (Count parameters:C259=2)
	APPEND TO ARRAY:C911(_LOGMETHOD_ExtraText; $2)
Else 
	APPEND TO ARRAY:C911(_LOGMETHOD_ExtraText; "")
End if 
APPEND TO ARRAY:C911(_LOGMETHOD_msStart; $vl_msStart)  //   Mod: DB (10/29/2010)
APPEND TO ARRAY:C911(_LOGMETHOD_wasteTime; 0)  //   Mod: DB (10/29/2010)

__incrementLevel:=__incrementLevel+1

