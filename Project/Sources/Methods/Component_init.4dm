//%attributes = {"invisible":true}
// Component_init ()
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (09/19/2012)
//   Mod by: Dani Beaubien (10/12/2012) - Changed location where the window prefs are stored
//   Mod: DB (02/24/2014) - Changed where the window prefs are stored.
//   Mod: DB (02/24/2014) - internal prefs are tied to an internal project name
// ----------------------------------------------------

var <>_hasBeenInitd : Boolean
If (Not:C34(<>_hasBeenInitd))
	<>_hasBeenInitd:=True:C214
	
	
	var $buildNoObj : Object
	$buildNoObj:=BuildNo_GetBuildNo_CodeAnalysis
	var <>SYS_Version : Text
	<>SYS_Version:=$buildNoObj.versionLong
	
	var <>SYS_PrefsFolder_t : Text
	<>SYS_PrefsFolder_t:=System folder:C487(User preferences_user:K41:4)+"Code Analysis"+Folder separator:K24:12  // Use a global location
	
	// Check to see if the preference file is in the "correct" place locally in the resource folder.
	//     Copy it if is not.
	var $File_pathNameTestCode; $File_pathNameTestCode2 : Integer
	$File_pathNameTestCode2:=Test path name:C476(Pref__GetFile2PrefFile)
	If ($File_pathNameTestCode2#1)  // Does not exist
		$File_pathNameTestCode:=Test path name:C476(Pref__GetFile2PrefFile_OLD)
		If ($File_pathNameTestCode=1)  // Does exist
			Folder_VerifyExistance(File_GetFolderName(Pref__GetFile2PrefFile))  // Ensure the needed folders exist
			COPY DOCUMENT:C541(Pref__GetFile2PrefFile_OLD; Pref__GetFile2PrefFile)  // Copy the preference file
		End if 
	End if 
	
End if 
