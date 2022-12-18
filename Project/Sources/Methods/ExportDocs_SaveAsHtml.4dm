//%attributes = {"invisible":true,"shared":true}
// ExportDocs_SaveAsHtml ()
// 
// DESCRIPTION
//   Scan all the methods and turn them into HTML docs.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien 03/01/12, 17:19:10
//   Mod by: Dani Beaubien (10/02/2012) - Add support to limit to just methods viewable by the host DB
// ----------------------------------------------------

If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
	
	C_PICTURE:C286($vg_icon)
	C_LONGINT:C283($progHdl)
	READ PICTURE FILE:C678(LibraryImage_GetPlatformPath("Progress_Write.png"); $vg_icon)
	$progHdl:=Progress New
	Progress SET ICON($progHdl; $vg_icon)
	Progress SET TITLE($progHdl; "Generated HTML Docs"; -1; "Initializing..."; True:C214)
	
	C_LONGINT:C283($vs1; $ve1)
	$vs1:=Milliseconds:C459
	MethodStats_RecalculateModified
	$ve1:=Milliseconds:C459
	
	// # Setup the root folder
	C_TEXT:C284($vt_rootFolder)
	$vt_rootFolder:=CodeAnalysis__GetDestFolder+Pref_GetPrefString("HTML2File Default Folder Name"; "Methods as HTML")+Folder separator:K24:12
	Folder_EmptyContents($vt_rootFolder)
	
	C_LONGINT:C283($vs2; $ve2)
	$vs2:=Milliseconds:C459
	Progress SET MESSAGE($progHdl; "Saving to disk...")
	ExportDocs__SaveMethodHtmlFiles($vt_rootFolder; $progHdl)
	
	Progress SET MESSAGE($progHdl; "Finalizing...")
	Progress SET PROGRESS($progHdl; -1)  // barber pole
	ExportDocs__SaveMainHtmlPage($vt_rootFolder)
	$ve2:=Milliseconds:C459
	
	
	// Put out some stats
	C_TEXT:C284(<>vt_ExportToResults)
	<>vt_ExportToResults:=<>vt_ExportToResults+"Export Completed to:\r "
	<>vt_ExportToResults:=<>vt_ExportToResults+$vt_rootFolder+"\r\r"
	<>vt_ExportToResults:=<>vt_ExportToResults+" Count - "+String:C10(Storage:C1525.methodStatsSummary.numMethods)+" files saved\r"
	<>vt_ExportToResults:=<>vt_ExportToResults+" Time to Scan - "+String:C10($ve1-$vs1; "###,###,###,##0")+"ms\r"
	<>vt_ExportToResults:=<>vt_ExportToResults+" Time To Disk - "+String:C10($ve2-$vs2; "###,###,###,##0")+"ms\r"
	POST OUTSIDE CALL:C329(<>_CodeAnalysis_ProcID)
	
	Progress QUIT($progHdl)
End if 