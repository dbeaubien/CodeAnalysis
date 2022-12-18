//%attributes = {"invisible":true}
// CODE_ExportAllToFiles
//
// DESCRIPTION
//   Exports all methods to the specified folder and does
//   extra folders as well.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien 09/18/12, 11:48:07
//   Mod by: Dani Beaubien (11/06/2012) - Moved all the code to a method
//   Mod by: Dani Beaubien (04/13/2014) - Added exporting of extra folders
// ----------------------------------------------------

C_LONGINT:C283(<>_CodeAnalysis_ProcID; <>_CA_QuickLauncher_ProcID)

If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
	C_TEXT:C284(<>vt_ExportToResults)
	<>vt_ExportToResults:="Preparing to Export all databse, project, object and form methods to text files.\rScanning Methods..."
	
	CA_SaveMethodsToTextFiles
	CA_SaveExtraFolders
	CA_SaveStructureDetails
	
	If (<>_CodeAnalysis_ProcID#0)
		POST OUTSIDE CALL:C329(<>_CodeAnalysis_ProcID)
	End if 
	If (<>_CA_QuickLauncher_ProcID#0)
		POST OUTSIDE CALL:C329(<>_CA_QuickLauncher_ProcID)
	End if 
End if 