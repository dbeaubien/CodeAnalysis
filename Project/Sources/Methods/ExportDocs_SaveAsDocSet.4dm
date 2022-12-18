//%attributes = {"invisible":true,"shared":true}
// ExportDocs_SaveAsDocSet
// 
// DESCRIPTION
//   Scan all the methods and turn them into HTML docs using the DocSet format.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien 03/01/12, 17:19:10
//   Mod by: Dani Beaubien (10/02/2012) - Add support to limit to just methods viewable by the host DB
//   Mod by: Dani Beaubien (02/04/2021) - Refactored to use objects
// ----------------------------------------------------

If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
	C_PICTURE:C286($vg_icon)
	C_LONGINT:C283($progHdl)
	READ PICTURE FILE:C678(LibraryImage_GetPlatformPath("Progress_Write.png"); $vg_icon)
	$progHdl:=Progress New
	Progress SET ICON($progHdl; $vg_icon)
	Progress SET TITLE($progHdl; "Generated HTML Docs"; -1; "Initializing..."; True:C214)
	
	MethodStats__Init
	MethodStats_RecalculateModified
	
	Pref_SetPrefString("HTML do Component View"; "1")  // Force to be only shared methods
	
	C_LONGINT:C283($vs1; $vs2; $vs3; $ve1; $ve2; $ve3)
	$vs1:=Milliseconds:C459
	MethodStats_RecalculateModified
	$ve1:=Milliseconds:C459
	
	// # Setup the folder paths
	C_TEXT:C284($vt_rootFolder; $vt_folder_Contents; $vt_folder_Resources; $vt_folder_Documents)
	$vt_rootFolder:=CodeAnalysis__GetDestFolder+File_GetFileName(Structure file:C489(*))+".docset"+Folder separator:K24:12
	$vt_folder_Contents:=$vt_rootFolder+"Contents"+Folder separator:K24:12
	$vt_folder_Resources:=$vt_folder_Contents+"Resources"+Folder separator:K24:12
	$vt_folder_Documents:=$vt_folder_Resources+"Documents"+Folder separator:K24:12
	Folder_EmptyContents($vt_rootFolder)
	Folder_VerifyExistance($vt_folder_Documents)
	
	
	// Copy the icon into the package
	COPY DOCUMENT:C541(Get 4D folder:C485(Current resources folder:K5:16)+"docset"+Folder separator:K24:12+"icon.png"; $vt_rootFolder+"icon.png")
	
	// Copy (and update) the Info.plist file into the package
	C_TEXT:C284($vt_tmpText)
	C_BLOB:C604($vx_tmpFile)
	DOCUMENT TO BLOB:C525(Get 4D folder:C485(Current resources folder:K5:16)+"docset"+Folder separator:K24:12+"Info.plist"; $vx_tmpFile)
	$vt_tmpText:=BLOB to text:C555($vx_tmpFile; UTF8 text without length:K22:17)
	$vt_tmpText:=Replace string:C233($vt_tmpText; "##ComponentName##"; File_GetFileName(Structure file:C489(*)))
	TEXT TO BLOB:C554($vt_tmpText; $vx_tmpFile; UTF8 text without length:K22:17)
	BLOB TO DOCUMENT:C526($vt_folder_Contents+"Info.plist"; $vx_tmpFile)
	
	
	
	// # Save to Disk
	$vs2:=Milliseconds:C459
	Progress SET MESSAGE($progHdl; "Saving methods to disk...")
	ExportDocs__SaveMethodHtmlFiles($vt_folder_Documents; $progHdl)
	Progress SET MESSAGE($progHdl; "Saving modules to disk...")
	ExportDocs___OutputModuleAsHTML($vt_folder_Documents; $progHdl)
	ExportDocs__SaveMainHtmlPage($vt_folder_Documents)
	$ve2:=Milliseconds:C459
	
	
	
	$vs3:=Milliseconds:C459
	// # Create the Sqlite file
	C_TEXT:C284($vt_commandToExecute)
	$vt_commandToExecute:="CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT);"
	$vt_commandToExecute:=$vt_commandToExecute+"CREATE UNIQUE INDEX anchor ON searchIndex (name, type, path);"
	Sqlite_DoCommand($vt_folder_Resources+"docSet.dsidx"; $vt_commandToExecute)
	$vt_commandToExecute:=""
	
	ARRAY TEXT:C222($projectMethodPathsArr; 0)
	METHOD GET PATHS:C1163(Path project method:K72:1; $projectMethodPathsArr)
	
	If (True:C214)  // # Add sqlite entries for each of the modules
		C_OBJECT:C1216($moduleCounts; $methodObj)
		C_LONGINT:C283($i)
		$moduleCounts:=New object:C1471
		For ($i; 1; Size of array:C274($projectMethodPathsArr))
			$methodObj:=MethodStatsMasterObj[$projectMethodPathsArr{$i}]
			If (String:C10($methodObj.in_module)#"") & (Bool:C1537($methodObj.is_shared))
				If ($moduleCounts[$methodObj.in_module]=Null:C1517)
					$moduleCounts[$methodObj.in_module]:=New object:C1471("count"; 1)
					$vt_commandToExecute:=$vt_commandToExecute+"INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES ('"+$methodObj.in_module+"', 'Module', '/Modules/"+$methodObj.in_module+".html');"
					If (Length:C16($vt_commandToExecute)>4096)
						Sqlite_DoCommand($vt_folder_Resources+"docSet.dsidx"; $vt_commandToExecute)
						$vt_commandToExecute:=""
					End if 
				End if 
			End if 
		End for 
		If ($vt_commandToExecute#"")
			Sqlite_DoCommand($vt_folder_Resources+"docSet.dsidx"; $vt_commandToExecute)
			$vt_commandToExecute:=""
		End if 
	End if 
	
	// # Add sqlite entries for each of the methods
	Progress SET MESSAGE($progHdl; "Step 5 of 5: Creating sqlite database...")
	$vt_commandToExecute:=""
	For ($i; 1; Size of array:C274($projectMethodPathsArr))
		Progress SET PROGRESS($progHdl; $i/Size of array:C274($projectMethodPathsArr))
		If (MethodStatsMasterObj[$projectMethodPathsArr{$i}].is_shared)
			$vt_commandToExecute:=$vt_commandToExecute+"INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES ('"+$projectMethodPathsArr{$i}+"', 'Method', '/Methods/"+$projectMethodPathsArr{$i}+".html');"
			If (Length:C16($vt_commandToExecute)>4096)
				Sqlite_DoCommand($vt_folder_Resources+"docSet.dsidx"; $vt_commandToExecute)
				$vt_commandToExecute:=""
			End if 
		End if 
	End for 
	If ($vt_commandToExecute#"")
		Sqlite_DoCommand($vt_folder_Resources+"docSet.dsidx"; $vt_commandToExecute)
		$vt_commandToExecute:=""
	End if 
	$ve3:=Milliseconds:C459
	
	
	// Put out some stats
	C_TEXT:C284(<>vt_ExportToResults)
	<>vt_ExportToResults:=<>vt_ExportToResults+"Docset Created on folder:\r "
	<>vt_ExportToResults:=<>vt_ExportToResults+Folder_ParentName($vt_rootFolder)+"\r\r"
	<>vt_ExportToResults:=<>vt_ExportToResults+" Time to Scan - "+String:C10($ve1-$vs1; "###,###,###,##0")+"ms\r"
	<>vt_ExportToResults:=<>vt_ExportToResults+" Time To Disk - "+String:C10($ve2-$vs2; "###,###,###,##0")+"ms\r"
	<>vt_ExportToResults:=<>vt_ExportToResults+" Time To Create Sqlite DB - "+String:C10($ve3-$vs3; "###,###,###,##0")+"ms\r"
	POST OUTSIDE CALL:C329(<>_CodeAnalysis_ProcID)  //   Mod: DB (06/14/2013)
	
	Progress QUIT($progHdl)
End if 