//%attributes = {"invisible":true}
// LogEvent_SetLogFolder ({pathToLogFolder}) 
// LogEvent_SetLogFolder ({text}) 
// 
// DESCRIPTION
//   Sets the folder that will contain all the log files.
//   If not path is passed then the default path is used.
//   The default path is a "Logs" folder beside the structure.
//   If we are 4D Remote then it is a "Logs" folder beside the 4d app.
//
C_TEXT:C284($1; <>LOG_FolderPathForLogFiles)
// ----------------------------------------------------
// CALLED BY
//   LogEvent_GetPathToLogFile
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/13/13)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 0; 1; Count parameters:C259))
	If (Count parameters:C259>=1)
		<>LOG_FolderPathForLogFiles:=$1
	End if 
	
	// If no value, then do default
	If (<>LOG_FolderPathForLogFiles="")
		If (Application type:C494#4D Remote mode:K5:5)
			<>LOG_FolderPathForLogFiles:=File_GetFolderName(Structure file:C489(*))
		Else 
			<>LOG_FolderPathForLogFiles:=File_GetFolderName(Application file:C491)
		End if 
		If (<>LOG_FolderPathForLogFiles=("@.4dbase"+Folder separator:K24:12))
			<>LOG_FolderPathForLogFiles:=File_GetFolderName(<>LOG_FolderPathForLogFiles)
		End if 
		If (<>LOG_FolderPathForLogFiles=("Components"+Folder separator:K24:12))
			<>LOG_FolderPathForLogFiles:=File_GetFolderName(<>LOG_FolderPathForLogFiles)
		End if 
		<>LOG_FolderPathForLogFiles:=<>LOG_FolderPathForLogFiles+"Code Analysis Logs"+Folder separator:K24:12
	End if 
	
	If (<>LOG_FolderPathForLogFiles#("@"+Folder separator:K24:12))
		<>LOG_FolderPathForLogFiles:=<>LOG_FolderPathForLogFiles+Folder separator:K24:12
	End if 
	
End if   // ASSERT