//%attributes = {"invisible":true}
// LogEvent_SetNewLogFrequency  (frequency)
// 
// DESCRIPTION
//   Define how often a new log file is created.
//   Frequency can be: "daily", "weekly", "monthly", and "yearly"
//   Weekly is the default.
//
#DECLARE($vt_frequency : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	var <>LOG_Frequency : Text
	If (DEV_ASSERT(STR_IsOneOf($vt_frequency; "daily"; "weekly"; "monthly"; "yearly"); "The passed frequency is not a valid value."))
		<>LOG_Frequency:=$vt_frequency
	Else 
		<>LOG_Frequency:="Weekly"
	End if 
End if 