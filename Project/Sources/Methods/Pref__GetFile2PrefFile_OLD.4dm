//%attributes = {"invisible":true}
// Pref__GetFile2PrefFile_OLD : filePath
// 
// DESCRIPTION
//   Returns the path to the location where the preference
//   file used to exist.
//
C_TEXT:C284($0)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (02/24/2014)
// ----------------------------------------------------

$0:=System folder:C487(User preferences_user:K41:4)+"Code Analysis"+Folder separator:K24:12+File_GetFileName(Structure file:C489(*))+Folder separator:K24:12+"Preferences.xml"
