//   Mod: DB (06/14/2013) - Update column header label
//   Mod by: Dani Beaubien (04/18/2014) - Add tab for "Folder DIFF"

//   Mod: DB (02/24/2014) - Show date and time of last method export
If (Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11)
	vt_lastExportDateTimeStr:="Last Method Export: "+Pref_GetPrefString("Export.MethodsAsTextLastUTC"; "unknown")
End if 


Case of 
	: (Form event code:C388=On Load:K2:1)
		Component_SetMenuBar
		MethodStats__Init  // Prep the vars
		
		C_OBJECT:C1216(selectedDiffMethod)  // from diff listbox
		C_LONGINT:C283(currentSelectedDiffMethod)
		Form:C1466.methodsWithDifference:=New collection:C1472
		Form:C1466.refreshDiff:=True:C214
		
		
	: (Form event code:C388=On Activate:K2:9)
		Component_SetMenuBar
		vt_defaultFolder:=CodeAnalysis__GetDestFolder
		
		// HANDLE THE REFRESH OF THE "Folder DIFF" tab
		If (True:C214)
			ARRAY TEXT:C222(at_XTRA_relativePaths; 0)
			ARRAY TEXT:C222(at_XTRA_comparePathsFULL; 0)
			ARRAY TEXT:C222(at_XTRA_actions; 0)
			Pref_GetPrefTextArray("Extra Folder"; ->at_XTRA_relativePaths)
			Pref_GetPrefTextArray("Extra Folder action"; ->at_XTRA_actions)
			Pref_GetPrefTextArray("Extra Folder CompareTo"; ->at_XTRA_comparePathsFULL)
			If (Size of array:C274(at_XTRA_comparePathsFULL)#Size of array:C274(at_XTRA_relativePaths))
				Array_SetSize(Size of array:C274(at_XTRA_relativePaths); ->at_XTRA_comparePathsFULL)
			End if 
			If (Size of array:C274(at_XTRA_actions)#Size of array:C274(at_XTRA_relativePaths))
				ARRAY TEXT:C222(at_XTRA_actions; Size of array:C274(at_XTRA_relativePaths))
			End if 
			SORT ARRAY:C229(at_XTRA_relativePaths; >)
			
			ARRAY TEXT:C222(at_XTRA_compareFolderName; Size of array:C274(at_XTRA_relativePaths))
			C_LONGINT:C283($i)
			For ($i; 1; Size of array:C274(at_XTRA_compareFolderName))
				Case of 
					: (at_XTRA_actions{$i}="Skip")
						at_XTRA_compareFolderName{$i}:=" ** Folder Marked to be Skipped **"
					: (at_XTRA_comparePathsFULL{$i}="")
						at_XTRA_compareFolderName{$i}:=" ** Set the Compare Folder **"
					Else 
						at_XTRA_compareFolderName{$i}:=File_GetFileName(at_XTRA_comparePathsFULL{$i})+Folder separator:K24:12
				End case 
			End for 
			
			
			OBJECT SET ENABLED:C1123(*; "BTN_XTRA_@"; False:C215)
			vt_fullPath:=""
			LISTBOX SELECT ROW:C912(*; "ListBox_Extras"; Size of array:C274(at_XTRA_compareFolderName)+1)
		End if 
		
		
	: (Form event code:C388=On Outside Call:K2:11)
		REDRAW WINDOW:C456
		SET TIMER:C645(1)  // do this until the external process finishes
		
		
	: (Form event code:C388=On Timer:K2:25)
		Case of 
			: (Process number:C372("CODE_ExportAllToFiles")#0)
			: (Process number:C372("ExportDocs_SaveAsHtml")#0)
			: (Process number:C372("CODE_Analysis")#0)
			Else 
				LogEvent_FlushCache  //   Mod: DB (09/15/2015) - Force cache to disk
				OBJECT SET ENABLED:C1123(*; "button@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "BTN_@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "CB_@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "TabControl_@"; True:C214)
				SET TIMER:C645(0)
				
				If (vt_lastDIFFCheck_Folder="")  // Mod by: Dani Beaubien (6/27/13) - Don't enable unless we have done a DIFF
					OBJECT SET ENABLED:C1123(BTN_Analysis_Recheck; False:C215)
				End if 
				
		End case 
End case 


If (Form:C1466.refreshDiff)
	Form:C1466.refreshDiff:=False:C215
	
	C_TEXT:C284(vt_lastDIFFCheck_Folder)
	If (vt_lastDIFFCheck_Folder#"")
		<>_DIFF_PathToFileOnDisk:=vt_lastDIFFCheck_Folder
		Form:C1466.methodsWithDifference:=New collection:C1472
		CODE_doDiffOnFolder(Form:C1466.methodsWithDifference)
	End if 
End if 