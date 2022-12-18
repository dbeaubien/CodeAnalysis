//%attributes = {"invisible":true}
// LogEvent_Write  (textToLog {; logType})
// LogEvent_Write  (text {; text})
// 
// DESCRIPTION
//   Adds the passed text to the log file cache.
//   logType defaults to "info" if not specified.
//
//   NOTE: A Carriage Return will always be added at
//   at the end of the textToLog.
//
//   Use LogEvent_FlushCache to force everything
//   to disk.
//
C_TEXT:C284($1; $vt_textToLog)
C_TEXT:C284($2; $vt_logType)  // OPTIONAL
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/13/13)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	$vt_textToLog:=$1
	$vt_textToLog:=$vt_textToLog+Char:C90(Carriage return:K15:38)
	
	If (Count parameters:C259>=2)
		$vt_logType:="Code Analysis "+$2
	End if 
	If ($vt_logType="")  // Force a default
		$vt_logType:="Code Analysis Log"
	End if 
	
	C_BOOLEAN:C305($vb_doFlushCache)
	C_TEXT:C284($vt_logFileName)
	$vt_logFileName:=File_GetFileName(LogEvent_GetPathToLogFile($vt_logType))
	
	Semaphore_WaitUntilGrabbed("LogWriteSemaphore")
	
	// Make sure that our cache has been created
	C_BOOLEAN:C305(<>LOG_CacheInitd)
	If (Not:C34(<>LOG_CacheInitd))
		ARRAY TEXT:C222(<>LOG_at_logFileName; 0)
		ARRAY TEXT:C222(<>LOG_at_cacheBuffer; 0)
		<>LOG_CacheInitd:=True:C214
		<>LOG_IsInDebugMode:=(Pref_GetGlobalPrefString("IsInLoggingMode"; "No")="Yes")
	End if 
	
	If (<>LOG_IsInDebugMode)
		// add the data to the log
		C_LONGINT:C283($vl_index)
		$vl_index:=Find in array:C230(<>LOG_at_logFileName; $vt_logFileName)
		If ($vl_index<1)
			APPEND TO ARRAY:C911(<>LOG_at_logFileName; $vt_logFileName)
			APPEND TO ARRAY:C911(<>LOG_at_cacheBuffer; $vt_textToLog)
			$vl_index:=Size of array:C274(<>LOG_at_logFileName)
		Else 
			<>LOG_at_cacheBuffer{$vl_index}:=<>LOG_at_cacheBuffer{$vl_index}+$vt_textToLog
		End if 
		
		If (Length:C16(<>LOG_at_cacheBuffer{$vl_index})>10240)
			$vb_doFlushCache:=True:C214
		End if 
	End if 
	
	Semaphore_Release("LogWriteSemaphore")
	
	If ($vb_doFlushCache)
		LogEvent_FlushCache
	End if 
	
End if   // ASSERT