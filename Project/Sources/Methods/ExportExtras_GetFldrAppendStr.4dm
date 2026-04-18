//%attributes = {"invisible":true}
// ExportExtras_GetFldrAppendStr () : strToAppendToExtrasFolderPath
//
// DESCRIPTION
//   Returns the text that should be appended to the exported "Extra" folders
//
#DECLARE()->$vt_AppendStr : Text
// ----------------------------------------------------

$vt_AppendStr:=""

var $vb_doAppendDate : Boolean
$vb_doAppendDate:=(Pref_GetPrefString("EXTRAS - Append to Folder Name")="Date@")
If ($vb_doAppendDate)  //   Mod by: Dani Beaubien (10/01/2012) - Append Date
	$vt_AppendStr:=$vt_AppendStr+Date2String(Current date:C33; " YYYY-MM-DD")
End if 

var $vb_doAppendTime : Boolean
$vb_doAppendTime:=(Pref_GetPrefString("EXTRAS - Append to Folder Name")="Date and Time")
If ($vb_doAppendTime)  //   Mod: DB (03/30/2014) - Append Time
	$vt_AppendStr:=$vt_AppendStr+Time2String(Current time:C178; " 24hh.mm.ss")
End if 
