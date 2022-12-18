//%attributes = {"invisible":true,"shared":true}
// CA_SaveExtraFolders ({rootFolderPath})
// CA_SaveExtraFolders ({text})
//
// DESCRIPTION
//   Calling this method will cause the component to export all the
//   identified extra folders.
//
//   If no folder is specified, then the folder as declared in the
//   component preferences will be used.
//
//   If a folder is specified, then that folder will be used as a destination
//   for the copied folders. The component preferences will be ignored.
//   NOTE: The destination folders will be created if they do not exist.
//   NOTE: The destination folders will be emptied prior to the start of the export.
//
C_TEXT:C284($1; $rootFolder)  // OPTIONAL - folder to store the exported resources
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (04/13/2014)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259<=1)
C_TEXT:C284($vt_AppendStr)
If (Count parameters:C259>=1)
	$rootFolder:=Folder_EnsureEndsInSeparator($1)
	If ($rootFolder="")
		$vt_AppendStr:=ExportExtras_GetFldrAppendStr
	End if 
Else 
	$rootFolder:=CodeAnalysis__GetDestFolder
End if 

ARRAY TEXT:C222($srcFolderPathsArray; 0)
ARRAY TEXT:C222($actionFolderPathsArray; 0)
ExportExtras_GetFolderPathsArr(->$srcFolderPathsArray; ->$actionFolderPathsArray)

C_COLLECTION:C1488($subfoldersToSkip)
$subfoldersToSkip:=New collection:C1472
For ($i; 1; Size of array:C274($srcFolderPathsArray))
	If ($actionFolderPathsArray{$i}="Skip")
		$subfoldersToSkip.push($srcFolderPathsArray{$i})
	End if 
End for 


// Copy the folders to their destinations
If (Size of array:C274($srcFolderPathsArray)>0)
	C_PICTURE:C286($vg_icon)
	READ PICTURE FILE:C678(LibraryImage_GetPlatformPath("Progress_Write.png"); $vg_icon)
	C_LONGINT:C283($progHdl)
	$progHdl:=Progress New
	Progress SET TITLE($progHdl; "Exporting Extra Folders"; 0; "Initializing..."; True:C214)
	Progress SET ICON($progHdl; $vg_icon)
	
	CAWindow_log("Exported "+String:C10(Size of array:C274($srcFolderPathsArray))+" Extra Folders to:\r ")
	CAWindow_log($rootFolder+"\r\r")
	
	// Copy the folders to their destinations
	C_LONGINT:C283($i; $vs1; $ve1)
	C_TEXT:C284($vt_dstFolderName)
	For ($i; 1; Size of array:C274($srcFolderPathsArray))
		If ($actionFolderPathsArray{$i}#"Skip")
			$vs1:=Milliseconds:C459
			$vt_dstFolderName:=$rootFolder+File_GetFileName($srcFolderPathsArray{$i})+$vt_AppendStr
			Folder_Copy($srcFolderPathsArray{$i}; $vt_dstFolderName; $subfoldersToSkip)
			$ve1:=Milliseconds:C459
			CAWindow_log(" #"+String:C10($i)+" - \""+File_GetFileName($srcFolderPathsArray{$i})+"\" copied ("+String:C10($ve1-$vs1)+"ms)\r")
			Progress SET PROGRESS($progHdl; $i/Size of array:C274($srcFolderPathsArray))
		End if 
	End for 
	
	CAWindow_log("\r")
	POST OUTSIDE CALL:C329(<>_CodeAnalysis_ProcID)  //   Mod: DB (06/14/2013)
	
	Progress QUIT($progHdl)
	DELAY PROCESS:C323(Current process:C322; 30)
End if 
