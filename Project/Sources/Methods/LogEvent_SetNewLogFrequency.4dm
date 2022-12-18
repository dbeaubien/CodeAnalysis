//%attributes = {"invisible":true}
// LogEvent_SetNewLogFrequency  (frequency)
// LogEvent_SetNewLogFrequency  (frequency)
// 
// DESCRIPTION
//   Define how often a new log file is created.
//   Frequency can be: "daily", "weekly", "monthly", and "yearly"
//   Weekly is the default.
//
C_TEXT:C284($1; $vt_frequency)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/13/13)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_frequency:=$1
	
	C_TEXT:C284(<>LOG_Frequency)
	If (DEV_ASSERT(STR_IsOneOf($vt_frequency; "daily"; "weekly"; "monthly"; "yearly"); "The passed frequency is not a valid value."))
		<>LOG_Frequency:=$vt_frequency
	Else 
		<>LOG_Frequency:="Weekly"
	End if 
End if   // ASSERT