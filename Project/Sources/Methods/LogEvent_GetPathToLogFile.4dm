//%attributes = {"invisible":true}
// LogEvent_GetPathToLogFile  (logType) : pathToLogFile
// 
// DESCRIPTION
//   Returns the path to the log file of the specified type.
//
#DECLARE($logType : Text)->$pathToLogFile : Text
// ----------------------------------------------------
$pathToLogFile:=""

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 0; 1; Count parameters:C259))
	If ($logType="")
		$logType:="info"
	End if 
	
	// Get the folder path to where the log files are stored
	$pathToLogFile:=LogEvent_GetLogFolder
	
	
	// Build the rest of the log file path
	var <>LOG_Frequency : Text  // Set by LogEvent_SetNewLogFrequency
	Case of   //   Mod: DB (11/26/2010)
		: (<>LOG_Frequency="Daily") | (<>LOG_Frequency="")
			$pathToLogFile:=$pathToLogFile+Date2String(Current date:C33; "YYYY-MM-DD")
			
		: (<>LOG_Frequency="Weekly")
			$pathToLogFile:=$pathToLogFile+String:C10(Year of:C25(Current date:C33))+DateTime_GetYearWeekNr(Current date:C33; " week wk")
			
		: (<>LOG_Frequency="Monthly")
			$pathToLogFile:=$pathToLogFile+String:C10(Year of:C25(Current date:C33))+"-"+String:C10(Month of:C24(Current date:C33); "00")
			
		: (<>LOG_Frequency="Yearly")
			$pathToLogFile:=$pathToLogFile+String:C10(Year of:C25(Current date:C33))
	End case 
	
	// Append our log type
	$pathToLogFile:=$pathToLogFile+" "+$logType+".txt"
End if 
