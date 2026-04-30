//%attributes = {"invisible":true}
// LogEvent_GetLogFolder : pathToLogFolder
// 
// DESCRIPTION
//   Returns the folder that the logs files will be saved
//   to.
//
#DECLARE() : Text
// ----------------------------------------------------

// Check to see it has been set yet, if not, then do the default
var <>LOG_FolderPathForLogFiles : Text
If (<>LOG_FolderPathForLogFiles="")
	LogEvent_SetLogFolder
End if 

return <>LOG_FolderPathForLogFiles