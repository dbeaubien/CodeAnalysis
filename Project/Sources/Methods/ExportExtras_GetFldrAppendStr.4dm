//%attributes = {"invisible":true}
// ExportExtras_GetFldrAppendStr () : strToAppendToExtrasFolderPath
// ExportExtras_GetFldrAppendStr () : text
//
// DESCRIPTION
//   Returns the text that should be appended to the exported "Extra" folders
//
C_TEXT:C284($0; $vt_AppendStr)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/15/2017)
// ----------------------------------------------------

$vt_AppendStr:=""

C_BOOLEAN:C305($vb_doAppendDate)
$vb_doAppendDate:=(Pref_GetPrefString("EXTRAS - Append to Folder Name")="Date@")
If ($vb_doAppendDate)  //   Mod by: Dani Beaubien (10/01/2012) - Append Date
	$vt_AppendStr:=$vt_AppendStr+Date2String(Current date:C33; " YYYY-MM-DD")
End if 

C_BOOLEAN:C305($vb_doAppendTime)
$vb_doAppendTime:=(Pref_GetPrefString("EXTRAS - Append to Folder Name")="Date and Time")
If ($vb_doAppendTime)  //   Mod: DB (03/30/2014) - Append Time
	$vt_AppendStr:=$vt_AppendStr+Time2String(Current time:C178; " 24hh.mm.ss")
End if 

$0:=$vt_AppendStr