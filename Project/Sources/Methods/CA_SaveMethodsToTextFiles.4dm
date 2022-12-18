//%attributes = {"invisible":true,"shared":true}
// CA_SaveMethodsToTextFiles ({rootFolderPath})
// CA_SaveMethodsToTextFiles ({text})
//
// DESCRIPTION
//   Calling this method will cause the component to export all the method
//   code.
//
//   If no folder is specified, then the folder as declared in the
//   component preferences will be used.
//
//   If a folder is specified, then that folder will be used as a destination
//   for the exported method code files. The component preferences will be ignored.
//   NOTE: The folder will be created if it does not exist.
//   NOTE: The folder will be emptied prior to the start of the export.
//
C_TEXT:C284($1; $vt_rootFolder)  // OPTIONAL - folder to store the exported method code
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (11/06/2012)
//   Mod by: Dani Beaubien (10/01/2012) - Support option to append date to export folder name
//   Mod by: Dani Beaubien (11/02/2012) - Use 4D v13 Progress bar
//   Mod: DB (12/29/2014) - Use the MethodStat methods & arrays
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259<=1)

If (Count parameters:C259>=1)
	$vt_rootFolder:=$1
	If ($vt_rootFolder#"")
		If ($vt_rootFolder[[Length:C16($vt_rootFolder)]]#Folder separator:K24:12)  // make sure the path ends in a folder
			$vt_rootFolder:=$vt_rootFolder+Folder separator:K24:12
		End if 
	End if 
End if 


// # Get the folder name all worked out
If ($vt_rootFolder="")
	C_BOOLEAN:C305($vb_doAppendDate; $vb_doAppendTime)
	If (Pref_GetPrefString("EXPORT - Append Date to Folder Name"; "1")="1")
		$vb_doAppendDate:=True:C214
		$vb_doAppendTime:=True:C214
	Else 
		$vb_doAppendDate:=(Pref_GetPrefString("EXPORT - Append to Folder Name")="Date@")
		$vb_doAppendTime:=(Pref_GetPrefString("EXPORT - Append to Folder Name")="Date and Time")
	End if 
	
	$vt_rootFolder:=CodeAnalysis__GetDestFolder+Pref_GetPrefString("EXPRT2File Default Folder Name"; "Methods Export")
	If ($vb_doAppendDate)  //   Mod by: Dani Beaubien (10/01/2012) - Append Date
		$vt_rootFolder:=$vt_rootFolder+Date2String(Current date:C33; " YYYY-MM-DD")
	End if 
	
	If ($vb_doAppendTime)  //   Mod: DB (03/30/2014) - Append Time
		$vt_rootFolder:=$vt_rootFolder+Time2String(Current time:C178; " 24hh.mm.ss")
	End if 
	
	$vt_rootFolder:=$vt_rootFolder+Folder separator:K24:12
End if 
Folder_VerifyExistance($vt_rootFolder)


C_LONGINT:C283($progHdl)
$progHdl:=Progress New

C_PICTURE:C286($vg_icon)
READ PICTURE FILE:C678(LibraryImage_GetPlatformPath("Progress_Write.png"); $vg_icon)
Progress SET ICON($progHdl; $vg_icon)
Progress SET TITLE($progHdl; "Exporting Method Code to Files"; -1; "Initializing..."; True:C214)

C_LONGINT:C283($vs1; $vs2; $ve1; $ve2)
$vs1:=Milliseconds:C459
MethodStats_RecalculateModified  //   Mod: DB (12/29/2014)
$ve1:=Milliseconds:C459

$vs2:=Milliseconds:C459
Progress SET MESSAGE($progHdl; "Saving to disk...")
MethodScan_OutputMethodsAsTEXT($vt_rootFolder; $progHdl)
$ve2:=Milliseconds:C459

//   Mod: DB (02/24/2014) - Record the last date and time that the export was done
Pref_SetPrefString("Export.MethodsAsTextLastUTC"; Date2String(CurrentDate; "MON dd, YYYY ")+Time2String(CurrentTime))

// Put out some stats and send back to parent window
C_TEXT:C284(<>vt_ExportToResults)
<>vt_ExportToResults:=<>vt_ExportToResults+"Export Completed to:\r "
<>vt_ExportToResults:=<>vt_ExportToResults+$vt_rootFolder+"\r\r"
<>vt_ExportToResults:=<>vt_ExportToResults+" Count - "+String:C10(Storage:C1525.methodStatsSummary.numMethods)+" methods\r"
<>vt_ExportToResults:=<>vt_ExportToResults+" Time to Scan - "+String:C10($ve1-$vs1; "###,###,###,##0")+"ms\r"
<>vt_ExportToResults:=<>vt_ExportToResults+" Time To Disk - "+String:C10($ve2-$vs2; "###,###,###,##0")+"ms\r"
<>vt_ExportToResults:=<>vt_ExportToResults+"\r"
POST OUTSIDE CALL:C329(<>_CodeAnalysis_ProcID)  //   Mod: DB (06/14/2013)

Progress QUIT($progHdl)
DELAY PROCESS:C323(Current process:C322; 30)

