//%attributes = {"invisible":true}
// MethodStats__SaveToDisk ()
// 
// DESCRIPTION
//   Stores the current method stats to disk.
//
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/17/2014)
//   Mod by: Dani Beaubien (02/02/2021) - Update to use the object
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=0)

Logging_Method_START(Current method name:C684)

C_TEXT:C284($folderForSavedStats)
$folderForSavedStats:=File_GetFolderName(Pref__GetFile2PrefFile)

File_Delete($folderForSavedStats+"method stats.json")
TEXT TO DOCUMENT:C1237($folderForSavedStats+"method stats.json"; JSON Stringify:C1217(Storage:C1525.methodStats; *); "utf-8"; Document unchanged:K24:18)

Logging_Method_STOP(Current method name:C684)
