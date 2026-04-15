//%attributes = {"invisible":true}
// LogEvent_Write  (textToLog {; logType})
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
#DECLARE($vt_textToLog : Text; $vt_logType : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	$vt_textToLog+=Char:C90(Carriage return:K15:38)
	
	If (Count parameters:C259>=2)
		$vt_logType:="Code Analysis "+$vt_logType
	End if 
	If ($vt_logType="")  // Force a default
		$vt_logType:="Code Analysis Log"
	End if 
	
	var $vb_doFlushCache : Boolean
	var $vt_logFileName : Text
	$vt_logFileName:=File_GetFileName(LogEvent_GetPathToLogFile($vt_logType))
	
	Semaphore_WaitUntilGrabbed("LogWriteSemaphore")
	
	// Make sure that our cache has been created
	var <>LOG_CacheInitd : Boolean
	If (Not:C34(<>LOG_CacheInitd))
		ARRAY TEXT:C222(<>LOG_at_logFileName; 0)
		ARRAY TEXT:C222(<>LOG_at_cacheBuffer; 0)
		<>LOG_CacheInitd:=True:C214
		<>LOG_IsInDebugMode:=(Pref_GetGlobalPrefString("IsInLoggingMode"; "No")="Yes")
	End if 
	
	If (<>LOG_IsInDebugMode)
		// add the data to the log
		var $vl_index : Integer
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
	
End if 