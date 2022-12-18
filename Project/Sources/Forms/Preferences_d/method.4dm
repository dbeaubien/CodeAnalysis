// Form Method

C_BOOLEAN:C305(<>ShowAboutPage)

Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(tabControl; 7)
		TabControl{1}:="General"
		TabControl{2}:=Get localized string:C991("TabLabel_Complexity")
		TabControl{3}:=Get localized string:C991("TabLabel_Differences")
		TabControl{4}:=Get localized string:C991("TabLabel_Methods")
		TabControl{5}:=Get localized string:C991("TabLabel_Folders")  //   Mod: DB (04/11/2014) - Added new tab
		TabControl{6}:=Get localized string:C991("TabLabel_Structure")
		TabControl{7}:=Get localized string:C991("TabLabel_About")
		
		Component_SetMenuBar
		
		C_TEXT:C284(vt_defaultFolder)
		vt_defaultFolder:=CodeAnalysis__GetDestFolder
		
		
		ARRAY TEXT:C222(at_XTRA_ignoreNames; 0)
		Pref_GetPrefTextArray("FileFolderNamesToIgnore"; ->at_XTRA_ignoreNames)
		OBJECT SET ENABLED:C1123(*; "BTN_XTRA2_@"; False:C215)
		
		
	: (Form event code:C388=On Activate:K2:9)
		Component_SetMenuBar
		
		// Handle the "Folders" tab
		If (True:C214)
			ARRAY TEXT:C222(at_XTRA_relativePaths; 0)
			ARRAY TEXT:C222(at_XTRA_comparePathsFULL; 0)
			ARRAY TEXT:C222(at_XTRA_actions; 0)
			Pref_GetPrefTextArray("Extra Folder"; ->at_XTRA_relativePaths)
			Pref_GetPrefTextArray("Extra Folder CompareTo"; ->at_XTRA_comparePathsFULL)
			Pref_GetPrefTextArray("Extra Folder action"; ->at_XTRA_actions)
			If (Size of array:C274(at_XTRA_actions)#Size of array:C274(at_XTRA_relativePaths))
				ARRAY TEXT:C222(at_XTRA_actions; Size of array:C274(at_XTRA_relativePaths))
				C_LONGINT:C283($i)
				For ($i; 1; Size of array:C274(at_XTRA_relativePaths))
					at_XTRA_actions{$i}:="Copy"
				End for 
				Pref_SetPrefTextArray("Extra Folder action"; ->at_XTRA_actions)
			End if 
			SORT ARRAY:C229(at_XTRA_relativePaths; at_XTRA_comparePathsFULL; at_XTRA_actions; >)
			
			If (Size of array:C274(at_XTRA_relativePaths)=0)
				OBJECT SET ENABLED:C1123(*; "BTN_XTRA_@"; False:C215)
				vt_fullPath:=""
				
			Else 
				C_LONGINT:C283($vl_col; $vl_row)
				LISTBOX GET CELL POSITION:C971(*; "ListBox_Extras"; $vl_col; $vl_row)
				If ($vl_row>Size of array:C274(at_XTRA_relativePaths))
					$vl_row:=Size of array:C274(at_XTRA_relativePaths)
				End if 
				If ($vl_row<=0)
					$vl_row:=1
				End if 
				LISTBOX SELECT ROW:C912(*; "ListBox_Extras"; $vl_row)
				vt_fullPath:=Folder_GetPathFrmRelativeToStct(at_XTRA_relativePaths{$vl_row})
				
				If (at_XTRA_actions{at_XTRA_relativePaths}="Copy")
					rb_CopyFolder:=1
					rb_SkipFolder:=0
				Else 
					rb_CopyFolder:=0
					rb_SkipFolder:=1
				End if 
				
				OBJECT SET ENABLED:C1123(*; "BTN_XTRA_@"; True:C214)
			End if 
		End if 
		
End case 


If (<>ShowAboutPage)
	FORM GOTO PAGE:C247(6)
	<>ShowAboutPage:=False:C215
End if 
