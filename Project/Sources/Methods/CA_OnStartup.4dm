//%attributes = {"shared":true}
// CA_OnStartup ()
//
// DESCRIPTION
//   Called from the Host Database On Startup method.
//   Does the initial initializations and opens any windows
//   as per the CodeAnalysis preferences.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (03/10/2021)
// ----------------------------------------------------

Case of 
	: (Is compiled mode:C492(*))
	: (Application type:C494=4D Server:K5:6)
	: (Application type:C494=4D Volume desktop:K5:2)
	Else 
		
		If (Pref_GetGlobalPrefString("OnStartup.OpenQuickLauncher"; "Yes")="Yes")
			CA_ShowQuickLauncher
		End if 
		
		If (Pref_GetGlobalPrefString("OnStartup.OpenMainWindow"; "No")="Yes")
			CA_ShowAnalysisWindow
		End if 
		
		If (Pref_GetGlobalPrefString("OnStartup.OpenExplorerWindow"; "Yes")="Yes")
			CA_ShowExplorer
		End if 
		
		If (Pref_GetGlobalPrefString("OnStartup.AddEventHandler"; "No")="Yes")
			ON EVENT CALL:C190("CA_EventHandler")
		End if 
		
End case 
