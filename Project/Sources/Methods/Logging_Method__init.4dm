//%attributes = {"invisible":true}
// Logging_Method__init ()
// 
// DESCRIPTION
//   Initializes the Logging Method vars
//
#DECLARE($force_init : Boolean)  // true forces an init
// ----------------------------------------------------

var __incrementLevel : Integer
var _LogMethod_inited : Boolean
If (Not:C34(_LogMethod_inited) || $force_init)
	_LogMethod_inited:=True:C214
	__incrementLevel:=0
	
	ARRAY TEXT:C222(_LOGMETHOD_CallingStack; 0)
	ARRAY TEXT:C222(_LOGMETHOD_ExtraText; 0)
	ARRAY LONGINT:C221(_LOGMETHOD_msStart; 0)  // Holds the start time of the method call
	ARRAY LONGINT:C221(_LOGMETHOD_wasteTime; 0)  // Holds time spent on internal calls
	
	ARRAY TEXT:C222(_LOGMETHOD_PROF_Method; 0)
	ARRAY LONGINT:C221(_LOGMETHOD_PROF_minTime; 0)
	ARRAY LONGINT:C221(_LOGMETHOD_PROF_maxTime; 0)
	ARRAY REAL:C219(_LOGMETHOD_PROF_totalTime; 0)
	ARRAY LONGINT:C221(_LOGMETHOD_PROF_count; 0)
End if 
