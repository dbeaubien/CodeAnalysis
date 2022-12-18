//%attributes = {"invisible":true}
// LogEvent_GetPathToLogFile  (logType) : pathToLogFile
// LogEvent_GetPathToLogFile  (text) : text
// 
// DESCRIPTION
//   Returns the path to the log file of the specified type.
//
C_TEXT:C284($1; $vt_logType)
C_TEXT:C284($0; $vt_pathToLogFile)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/13/13)
// ----------------------------------------------------

$vt_pathToLogFile:=""
If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 0; 1; Count parameters:C259))
	If (Count parameters:C259>=1)
		$vt_logType:=$1
	End if 
	
	If ($vt_logType="")
		$vt_logType:="info"
	End if 
	
	// Get the folder path to where the log files are stored
	$vt_pathToLogFile:=LogEvent_GetLogFolder
	
	
	// Build the rest of the log file path
	C_TEXT:C284(<>LOG_Frequency)  // Set by LogEvent_SetNewLogFrequency
	Case of   //   Mod: DB (11/26/2010)
		: (<>LOG_Frequency="Daily") | (<>LOG_Frequency="")
			$vt_pathToLogFile:=$vt_pathToLogFile+Date2String(CurrentDate; "YYYY-MM-DD")
			
		: (<>LOG_Frequency="Weekly")
			$vt_pathToLogFile:=$vt_pathToLogFile+String:C10(Year of:C25(CurrentDate))+DateTime_GetYearWeekNr(CurrentDate; " week wk")
			
		: (<>LOG_Frequency="Monthly")
			$vt_pathToLogFile:=$vt_pathToLogFile+String:C10(Year of:C25(CurrentDate))+"-"+String:C10(Month of:C24(CurrentDate); "00")
			
		: (<>LOG_Frequency="Yearly")
			$vt_pathToLogFile:=$vt_pathToLogFile+String:C10(Year of:C25(CurrentDate))
	End case 
	
	// Append our log type
	$vt_pathToLogFile:=$vt_pathToLogFile+" "+$vt_logType+".txt"
End if   // ASSERT
$0:=$vt_pathToLogFile