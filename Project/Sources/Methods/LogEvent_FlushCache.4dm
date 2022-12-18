//%attributes = {"invisible":true}
// LogEvent_FlushCache
// 
// DESCRIPTION
//   Force the events in the log caches to disk.
//
If (False:C215)  // To stop this showing on tool tips
	// ----------------------------------------------------
	// HISTORY
	//   Created by: DB (03/13/13)
	// ----------------------------------------------------
End if 

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 0; Count parameters:C259))
	C_BOOLEAN:C305(<>LOG_CacheInitd)
	If (<>LOG_CacheInitd)
		
		Semaphore_WaitUntilGrabbed("LogWriteSemaphore")
		
		C_TEXT:C284($vt_filePathToLogFile)
		C_LONGINT:C283($i)
		For ($i; Size of array:C274(<>LOG_at_logFileName); 1; -1)
			Folder_VerifyExistance(LogEvent_GetLogFolder)  // Only do this if there is something to write out
			$vt_filePathToLogFile:=LogEvent_GetLogFolder+<>LOG_at_logFileName{$i}
			
			// Ensure the file has been created and then open it
			C_TIME:C306($vh_logFileRef)
			If (File_DoesExist($vt_filePathToLogFile))
				$vh_logFileRef:=Append document:C265($vt_filePathToLogFile)
			Else 
				$vh_logFileRef:=Create document:C266($vt_filePathToLogFile)
			End if 
			
			// Dump the contents to the file
			If (OK=1)
				SEND PACKET:C103($vh_logFileRef; <>LOG_at_cacheBuffer{$i})
				CLOSE DOCUMENT:C267($vh_logFileRef)
				DELETE FROM ARRAY:C228(<>LOG_at_logFileName; $i; 1)
				DELETE FROM ARRAY:C228(<>LOG_at_cacheBuffer; $i; 1)
			End if 
		End for 
		
		Semaphore_Release("LogWriteSemaphore")
	End if 
End if   // ASSERT