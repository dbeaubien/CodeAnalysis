//%attributes = {"invisible":true}
// CODE_ExportProperties
//
// DESCRIPTION
//   Exports the structure properties
//   folder specified by <>_CODEANALYSIS_FLDR_SUFFIX.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (06/14/13)
//   Mod: DB (01/20/2015) - Added a better error message if the sturcture is not installed.
//   Mod: DB (09/02/2015) - Reworked to use v14 features. Does not rely on project form in host DB.
// ----------------------------------------------------

If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
	C_TEXT:C284($vt_onErrorMethod)
	$vt_onErrorMethod:=Method called on error:C704
	OnErr_ClearError
	ON ERR CALL:C155("OnErr_GENERIC_Quiet")
	
	C_TEXT:C284(<>_CODEANALYSIS_FLDR_SUFFIX)  // used in the CA_SaveFormProperties method.
	<>_CODEANALYSIS_FLDR_SUFFIX:=""
	
	C_BOOLEAN:C305($vb_doAppendDate; $vb_doAppendTime)
	If (Pref_GetPrefString("EXPORT - Append Date to Form Folder Name"; "1")="1")  //   Mod: DB (08/29/2015)
		$vb_doAppendDate:=True:C214
		$vb_doAppendTime:=True:C214
	Else 
		$vb_doAppendDate:=(Pref_GetPrefString("EXPORT - Append to Form Folder Name"; "Date and Time")="Date@")  //   Mod: DB (08/29/2015)
		$vb_doAppendTime:=(Pref_GetPrefString("EXPORT - Append to Form Folder Name")="Date and Time")  //   Mod: DB (08/29/2015)
	End if 
	
	If ($vb_doAppendDate)  //   Mod by: Dani Beaubien (10/01/2012) - Append Date?
		<>_CODEANALYSIS_FLDR_SUFFIX:=Date2String(Current date:C33; " YYYY-MM-DD")
	End if 
	
	If ($vb_doAppendTime)  //   Mod: DB (08/29/2015)
		<>_CODEANALYSIS_FLDR_SUFFIX:=<>_CODEANALYSIS_FLDR_SUFFIX+Time2String(Current time:C178; " 24hh.mm.ss")
	End if 
	
	C_LONGINT:C283($progHdl; $progHdl2)
	$progHdl:=Progress New
	
	C_PICTURE:C286($vg_icon)
	READ PICTURE FILE:C678(LibraryImage_GetPlatformPath("Progress_Write.png"); $vg_icon)
	Progress SET ICON($progHdl; $vg_icon)
	
	Progress SET TITLE($progHdl; "Export Form Properties"; -1; "Initializing..."; True:C214)
	Progress SET PROGRESS($progHdl; -1)
	//Progress SET BUTTON ENABLED ($progHdl;True)
	
	$progHdl2:=Progress New
	
	READ PICTURE FILE:C678(LibraryImage_GetPlatformPath("Progress_AddCode.png"); $vg_icon)
	Progress SET ICON($progHdl2; $vg_icon)
	
	Progress SET TITLE($progHdl2; "Installing Code Analysis Code Stubs"; -1; "Initializing..."; True:C214)
	//Progress SET BUTTON ENABLED ($progHdl2;True)
	
	Host_GetAssetInfo_CheckVersion  // Mod by: Dani Beaubien (07/02/2013) - Moved to own method
	
	Progress QUIT($progHdl2)
	
	
	
	C_LONGINT:C283($vl_maxCount)
	$vl_maxCount:=Get last table number:C254+1
	
	
	C_BOOLEAN:C305($vb_noResult)
	C_LONGINT:C283($vl_tableNo; $vl_count)
	$vl_tableNo:=0
	
	// Process the table forms
	C_POINTER:C301($vp_table)
	For ($vl_tableNo; 1; Get last table number:C254)
		If (Is table number valid:C999($vl_tableNo))
			$vp_table:=Table:C252($vl_tableNo)
			Progress SET MESSAGE($progHdl; "Scanning ["+Table name:C256($vl_tableNo)+"] forms...")
			
			ARRAY TEXT:C222(at_projectFormNames; 0)
			Host_GetAssetInfo_GetTableForms($vl_tableNo; ->at_projectFormNames)
			//LogEvent_Write ("Host_GetAssetInfo_GetTableForms returned "+String(Size of array(at_projectFormNames))+" for table "+Table name($vl_tableNo)+".")
			
			C_LONGINT:C283($i)
			For ($i; 1; Size of array:C274(at_projectFormNames))
				$vl_count:=$vl_count+1
				$vb_noResult:=CA_SaveFormProperties($vl_tableNo; at_projectFormNames{$i})
			End for 
			
		Else 
			Progress SET MESSAGE($progHdl; "Scanning forms...")
		End if 
		
		Progress SET PROGRESS($progHdl; ($vl_tableNo/$vl_maxCount))
	End for 
	
	// Process the project forms
	Progress SET MESSAGE($progHdl; "Scanning project forms...")
	ARRAY TEXT:C222(at_projectFormNames; 0)
	Host_GetAssetInfo_GetProjForms(->at_projectFormNames)
	
	For ($i; 1; Size of array:C274(at_projectFormNames))
		If (at_projectFormNames{$i}#"CodeAnalysis_FormScanner")  // Do not scan the form we are using for the form properties export
			$vb_noResult:=CA_SaveFormProperties(0; at_projectFormNames{$i})
		End if 
	End for 
	
	Progress SET PROGRESS($progHdl; 1)
	
	Progress QUIT($progHdl)
	
	BEEP:C151
	ALERT:C41(String:C10($vl_count)+" table forms saved to disk.\r"+String:C10(Size of array:C274(at_projectFormNames))+" project forms saved to disk.")
	ARRAY TEXT:C222(at_projectFormNames; 0)  // Clean up
	<>_CODEANALYSIS_FLDR_SUFFIX:=""
	
	
	OnErr_ClearError
	ON ERR CALL:C155($vt_onErrorMethod)  // restore our method
	
	POST OUTSIDE CALL:C329(<>_CodeAnalysis_ProcID)  //   Mod: DB (06/14/2013)
End if 