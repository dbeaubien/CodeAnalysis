//%attributes = {"invisible":true,"preemptive":"capable"}
// Logging_Method_START (methodName {;optionalText})
// 
// DESCRIPTION
//   Used to log entering a method.
//
#DECLARE($method_name : Text; $extra : Text)
// ----------------------------------------------------

Logging_Method__init

var _LOGMETHOD_exists : Boolean
_LOGMETHOD_exists:=True:C214

var $vl_msStart : Integer
$vl_msStart:=Milliseconds:C459

// Add our method to the call stack
APPEND TO ARRAY:C911(_LOGMETHOD_CallingStack; $method_name)
If (Count parameters:C259=2)
	APPEND TO ARRAY:C911(_LOGMETHOD_ExtraText; $extra)
Else 
	APPEND TO ARRAY:C911(_LOGMETHOD_ExtraText; "")
End if 
APPEND TO ARRAY:C911(_LOGMETHOD_msStart; $vl_msStart)  //   Mod: DB (10/29/2010)
APPEND TO ARRAY:C911(_LOGMETHOD_wasteTime; 0)  //   Mod: DB (10/29/2010)

__incrementLevel:=__incrementLevel+1

