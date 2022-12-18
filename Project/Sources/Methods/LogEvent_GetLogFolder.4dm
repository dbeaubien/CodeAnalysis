//%attributes = {"invisible":true}
// LogEvent_GetLogFolder : pathToLogFolder
// LogEvent_GetLogFolder : text
// 
// DESCRIPTION
//   Returns the folder that the logs files will be saved
//   to.
//
C_TEXT:C284($0; <>LOG_FolderPathForLogFiles)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/13/13)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 0; Count parameters:C259))
	
	// Check to see it has been set yet, if not, then do the default
	If (<>LOG_FolderPathForLogFiles="")
		LogEvent_SetLogFolder
	End if 
	
End if   // ASSERT
$0:=<>LOG_FolderPathForLogFiles