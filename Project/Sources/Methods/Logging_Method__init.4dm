//%attributes = {"invisible":true}
// Logging_Method__init ()
// 
// DESCRIPTION
//   Initializes the Logging Method vars
//
C_BOOLEAN:C305($1)  // true forces an init
// ----------------------------------------------------
// CALLED BY
//   Logging_Method_START
//   Logging_Method_STOP
// ----------------------------------------------------
// HISTORY
//   Created by: DB (01/14/09)
// ----------------------------------------------------

C_BOOLEAN:C305(_LogMethod_inited)
If (Count parameters:C259>=1)
	_LogMethod_inited:=Not:C34($1)
End if 

C_BOOLEAN:C305(<>TrackPerformance)
If (Not:C34(_LogMethod_inited))
	_LogMethod_inited:=True:C214
	C_LONGINT:C283(__incrementLevel)
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
