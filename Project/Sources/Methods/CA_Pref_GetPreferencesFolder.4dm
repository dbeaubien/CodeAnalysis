//%attributes = {"invisible":true,"shared":true}
// CA_Pref_GetPreferencesFolder : folderPath
// CA_Pref_GetPreferencesFolder : text
//
// DESCRIPTION
//   This method will return the full path to the folder
//   that the Component users for all it stored preferences
//   and cached statistics.
//
C_TEXT:C284($0)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/25/2017)
// ----------------------------------------------------

$0:=Pref__GetFile2PrefFile