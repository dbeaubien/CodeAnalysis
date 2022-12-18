//   Mod: Dani Beaubien (10/25/2012) - Added support for ignoring multiple spaces and mixed case.
//   Mod: Dani Beaubien (09/26/2013) - No line number on first line if it is an attribute line
//   Mod: DB (05/14/2014) - Implement alternate view

C_TEXT:C284($vt_theCode)

C_LONGINT:C283(_FORM_CurrentPage)
If (Form event code:C388=On Load:K2:1)  //   Mod: DB (05/14/2014)
	If (Pref_GetPrefString("DIFF DifferenceView")="")
		_FORM_CurrentPage:=1
	Else 
		FORM GOTO PAGE:C247(2)
		_FORM_CurrentPage:=2
	End if 
	
End if 

// Do the Diff
If (Form event code:C388=On Load:K2:1) | (BTN_Rescan=1)
	
	//   Mod: DB (03/29/2014) - Reset the buttons
	OBJECT SET ENABLED:C1123(*; "BTN_CopyToMethod"; True:C214)
	OBJECT SET ENABLED:C1123(*; "BTN_CopyToDisk"; True:C214)
	OBJECT SET TITLE:C194(*; "BTN_CopyToMethod"; "<-- Apply")
	OBJECT SET TITLE:C194(*; "BTN_CopyToDisk"; "Apply -->")
	
	// --------- Grab the method code and get it ready
	ARRAY TEXT:C222(DEMO_File1_at; 0)
	ARRAY LONGINT:C221(DEMO_File1LineNo_al; 0)
	C_BOOLEAN:C305($vb_MethodDoesExist)
	If (_DIFF_MethodName#"")
		OnErr_ClearError
		ON ERR CALL:C155("OnErr_GENERIC")
		$vt_theCode:=Method_GetNormalizedCode(_DIFF_MethodName)  //   Mod by: Dani Beaubien (02/17/2014) 
		ON ERR CALL:C155("")
		
		$vt_theCode:=MethodDiff_d_ApplyCodePrefs($vt_theCode)  // Handle the configuration checkboxes on the dialog
		ARRAY_Unpack($vt_theCode; ->DEMO_File1_at; Pref_GetEOL)  //   Mod by: Dani Beaubien (02/17/2014)
		//ARRAY_Unpack ($vt_theCode;->DEMO_File1_at;"\r")
		
		OBJECT SET ENABLED:C1123(BTN_OpenMthd; True:C214)
		If (gError#0)  // method does not exist in the structure
			OBJECT SET ENABLED:C1123(BTN_OpenMthd; False:C215)
		Else 
			$vb_MethodDoesExist:=True:C214
		End if 
	End if 
	
	
	// --------- Grab the code from the file (on disk) and get it ready
	ARRAY TEXT:C222(DEMO_File2_at; 0)
	ARRAY LONGINT:C221(DEMO_File2LineNo_al; 0)
	C_BOOLEAN:C305($vb_FileDoesExist)
	If (File_DoesExist(_DIFF_PathToFileOnDisk))
		C_TIME:C306($File2_h)
		$File2_h:=Open document:C264(_DIFF_PathToFileOnDisk)
		If (OK=1)
			RECEIVE PACKET:C104($File2_h; $vt_theCode; 1024*256)
			CLOSE DOCUMENT:C267($File2_h)
		End if 
		
		C_TEXT:C284($vt)
		$vt_theCode:=MethodDiff_d_ApplyCodePrefs($vt_theCode)  // Handle the configuration checkboxes on the dialog
		$vt:=STR_TellMeTheEOL($vt_theCode)
		ARRAY_Unpack($vt_theCode; ->DEMO_File2_at; STR_TellMeTheEOL($vt_theCode))
		$vb_FileDoesExist:=True:C214
	Else 
		OBJECT SET ENABLED:C1123(BTN_OpenFile; False:C215)
		$vb_FileDoesExist:=False:C215
	End if 
	
	
	// Make sure that there is at least 1 row
	If (Size of array:C274(DEMO_File1_at)=0)
		APPEND TO ARRAY:C911(DEMO_File1_at; "")
	End if 
	If (Size of array:C274(DEMO_File2_at)=0)
		APPEND TO ARRAY:C911(DEMO_File2_at; "")
	End if 
	
	
	// ##### Do the Diff
	ARRAY LONGINT:C221($StartA; 0)
	ARRAY LONGINT:C221($StartB; 0)
	ARRAY LONGINT:C221($DeletedA; 0)
	ARRAY LONGINT:C221($InsertedB; 0)
	C_BOOLEAN:C305($vb_ignoreMultipleSpaces)  //   Mod by: Dani Beaubien (10/25/2012)
	C_BOOLEAN:C305($vb_ignoreCase)  //   Mod by: Dani Beaubien (10/25/2012)
	$vb_ignoreMultipleSpaces:=(Num:C11(Pref_GetPrefString("DIFF ignoreMultipleSpaces"; ""))=1)  //   Mod by: Dani Beaubien (10/25/2012)
	$vb_ignoreCase:=(Num:C11(Pref_GetPrefString("DIFF ignoreCase"; ""))=1)  //   Mod by: Dani Beaubien (10/25/2012)
	_DIFF_Diff(->DEMO_File1_at; ->DEMO_File2_at; ->$StartA; ->$StartB; ->$DeletedA; ->$InsertedB; $vb_ignoreMultipleSpaces; $vb_ignoreCase)  //   Mod by: Dani Beaubien (10/25/2012)
	_DIFF_Synchronise(->DEMO_File1_at; ->DEMO_File2_at; ->$StartA; ->$StartB; ->$DeletedA; ->$InsertedB; ->DEMO_File1LineNo_al; ->DEMO_File2LineNo_al; ->DEMO_FontColors_al; 0x0000; 0x00E1E1E1; 0x00E1E1E1)
	
	//   Mod by: Dani Beaubien (10/15/2012) - Show the change string (for testing)
	//If (Macintosh option down | Windows Alt down) & (Not(Is compiled mode))
	//$Changes_t:=_DIFF_ChangesText (->$StartA;->$StartB;->$DeletedA;->$InsertedB)
	//SET TEXT TO PASTEBOARD($Changes_t)
	//ALERT("Change String is: "+$Changes_t+"\r\rSent to Clipboard")
	//End if 
	
	
	// ##### Go through the methods and indent so that it is easier to read.
	MethodScan_IndentCodeInArray(->DEMO_File1_at)
	MethodScan_IndentCodeInArray(->DEMO_File2_at)
	
	
	
	// ##### Move the font colour to the background colour
	ARRAY LONGINT:C221(DEMO_BackColors_al; Size of array:C274(DEMO_FontColors_al))
	ARRAY LONGINT:C221(DEMO_Styles_al; Size of array:C274(DEMO_FontColors_al))
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274(DEMO_FontColors_al))
		DEMO_Styles_al{$i}:=-255  // default
		DEMO_BackColors_al{$i}:=0x00FFFFFF  // no change
		
		If (DEMO_FontColors_al{$i}#0x0000)
			DEMO_BackColors_al{$i}:=DEMO_FontColors_al{$i}
			DEMO_Styles_al{$i}:=Italic:K14:3
		End if 
		DEMO_FontColors_al{$i}:=0x0000  // Clear this
	End for 
	
	
	
	ARRAY LONGINT:C221(DEMO_ALT_File1LineNo_al; 0)
	ARRAY LONGINT:C221(DEMO_ALT_File2LineNo_al; 0)
	If (_FORM_CurrentPage=2)  // 2nd Tab view only
		COPY ARRAY:C226(DEMO_File1LineNo_al; DEMO_ALT_File1LineNo_al)
		COPY ARRAY:C226(DEMO_File2LineNo_al; DEMO_ALT_File2LineNo_al)
		
		
		// If there is an attribute line, the adjust the line #s so that the attribute line is line #0
		If (Size of array:C274(DEMO_ALT_File1LineNo_al)>0)
			If (DEMO_File1_at{1}="@//%attributes = @")  // Check the left side
				For ($i; 1; Size of array:C274(DEMO_ALT_File1LineNo_al))
					If (DEMO_ALT_File1LineNo_al{$i}>0)
						DEMO_ALT_File1LineNo_al{$i}:=DEMO_ALT_File1LineNo_al{$i}-1
					End if 
				End for 
			End if 
			
			If (DEMO_File2_at{1}="@//%attributes = @")  // Check the right side
				For ($i; 1; Size of array:C274(DEMO_ALT_File2LineNo_al))
					If (DEMO_ALT_File2LineNo_al{$i}>0)
						DEMO_ALT_File2LineNo_al{$i}:=DEMO_ALT_File2LineNo_al{$i}-1
					End if 
				End for 
			End if 
		End if   // (Size of array(DEMO_ALT_File1LineNo_al)>0)
		
		
		//   Mod: DB (05/15/2015) - Identify the single line changes; set the array true on those lines
		ARRAY BOOLEAN:C223($ab_startOfSingleLineChange; Size of array:C274(DEMO_File2LineNo_al))
		C_LONGINT:C283($vl_curState)
		C_BOOLEAN:C305($vb_isSingleLineChange)
		$vl_curState:=0
		For ($i; 1; Size of array:C274(DEMO_File2LineNo_al))
			$vb_isSingleLineChange:=False:C215
			
			Case of 
				: (DEMO_File1LineNo_al{$i}#0) & (DEMO_File2LineNo_al{$i}#0)  // no change
					If ($vl_curState=3)
						$vb_isSingleLineChange:=True:C214
					End if 
					$vl_curState:=0
					
					
				: (DEMO_File1LineNo_al{$i}#0) & (DEMO_File2LineNo_al{$i}=0)  // line added
					Case of 
						: ($vl_curState=0)  // 1st line to be added
							$vl_curState:=1
							
						: ($vl_curState=1) | ($vl_curState=2)  // more than one line added
							$vl_curState:=2
					End case 
					
					
				: (DEMO_File1LineNo_al{$i}=0) & (DEMO_File2LineNo_al{$i}#0)  // line removed
					Case of 
						: ($vl_curState=0)  // line to be Removed but no lines where added
							$vl_curState:=0
							
						: ($vl_curState=1)  // 1st line to be Removed
							$vl_curState:=3
							
						: ($vl_curState=3) | ($vl_curState=4)  // more than one line removed after an add
							$vl_curState:=4
					End case 
					
			End case 
			
			If (($vl_curState=3) & ($i=Size of array:C274(DEMO_File2LineNo_al)))
				$ab_startOfSingleLineChange{$i-1}:=True:C214  // line added
				//$ab_startOfSingleLineChange{$i}:=True  // line removed
			Else 
				If ($vb_isSingleLineChange)
					$ab_startOfSingleLineChange{$i-2}:=True:C214  // line added
					//$ab_startOfSingleLineChange{$i-1}:=True  // line removed
				End if 
			End if 
			
		End for 
		
		
		// Construct our alternate view of the method differences
		ARRAY LONGINT:C221(DEMO_BackColors_ALT_al; Size of array:C274(DEMO_File2LineNo_al))
		ARRAY TEXT:C222(DEMO_ALT_MethodLines_at; Size of array:C274(DEMO_File2LineNo_al))
		For ($i; 1; Size of array:C274(DEMO_File2LineNo_al))
			
			//   Mod: DB (05/15/2015) - v1.7.1 - Highlight changes that have been made to a single line
			If ($ab_startOfSingleLineChange{$i})  // & (False)
				ARRAY LONGINT:C221($StartA; 0)
				ARRAY LONGINT:C221($StartB; 0)
				ARRAY LONGINT:C221($DeletedA; 0)
				ARRAY LONGINT:C221($InsertedB; 0)
				_DIFF_Diff(->DEMO_File1_at{$i}; ->DEMO_File2_at{$i+1}; ->$StartA; ->$StartB; ->$DeletedA; ->$InsertedB)
				
				C_LONGINT:C283($j)
				For ($j; 1; Size of array:C274($StartA))
					If ($DeletedA{$j}>0)
						DEMO_File1_at{$i}:=Utility_MakeTextStyleSafe(DEMO_File1_at{$i})  //   Mod: DB (11/21/2013) - First style setting?
						ST SET ATTRIBUTES:C1093(DEMO_File1_at{$i}; $StartA{$j}; $StartA{$j}+$DeletedA{$j}; Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute text color:K65:7; "#009000")
					End if 
					
					If ($InsertedB{$j}>0)
						DEMO_File2_at{$i+1}:=Utility_MakeTextStyleSafe(DEMO_File2_at{$i+1})  //   Mod: DB (11/21/2013) - First style setting?
						ST SET ATTRIBUTES:C1093(DEMO_File2_at{$i+1}; $StartB{$j}; $StartB{$j}+$InsertedB{$j}; Attribute bold style:K65:1; 1; Attribute underline style:K65:4; 1; Attribute text color:K65:7; "#D00000")
					End if 
				End for 
			End if 
			
			// Change the background colour of the line based on the type of change
			Case of 
				: (DEMO_File1LineNo_al{$i}#0) & (DEMO_File2LineNo_al{$i}=0)  // line added
					DEMO_BackColors_ALT_al{$i}:=0x00B9FFB9  // GREEN
					DEMO_ALT_MethodLines_at{$i}:="+ "+Utility_MakeTextStyleSafe(DEMO_File1_at{$i})
					
				: (DEMO_File1LineNo_al{$i}=0) & (DEMO_File2LineNo_al{$i}#0)  // line removed
					DEMO_BackColors_ALT_al{$i}:=0x00FFB9B9  // RED
					DEMO_ALT_MethodLines_at{$i}:="- "+Utility_MakeTextStyleSafe(DEMO_File2_at{$i})
					
				Else   // normal situation
					DEMO_BackColors_ALT_al{$i}:=DEMO_BackColors_al{$i}
					DEMO_ALT_MethodLines_at{$i}:="  "+Utility_MakeTextStyleSafe(DEMO_File1_at{$i})
			End case 
			
		End for 
	End if 
	
	
	If (_FORM_CurrentPage=1)  // 1st Tab view only
		MethodDiff_d_CollapseCols  //   Mod by: Dani Beaubien (10/26/2012) - Collapse the cols
		MethodDiff_d_IdentifyLineDiff
		
		If (Size of array:C274(DEMO_File1LineNo_al)>0)
			If (DEMO_File1_at{1}="@//%attributes = @")  // Check the left side
				For ($i; 1; Size of array:C274(DEMO_File1LineNo_al))
					If (DEMO_File1LineNo_al{$i}>0)
						DEMO_File1LineNo_al{$i}:=DEMO_File1LineNo_al{$i}-1
					End if 
				End for 
			End if 
			
			If (DEMO_File2_at{1}="@//%attributes = @")  // Check the right side
				For ($i; 1; Size of array:C274(DEMO_File2LineNo_al))
					If (DEMO_File2LineNo_al{$i}>0)
						DEMO_File2LineNo_al{$i}:=DEMO_File2LineNo_al{$i}-1
					End if 
				End for 
			End if 
		End if   // (Size of array(DEMO_File1LineNo_al)>0)
		
	End if 
	
	
	
	//   Mod by: Dani Beaubien (10/15/2012) - Figure out the # of changes
	C_LONGINT:C283(_DIFF_NumDifferences)
	If (_FORM_CurrentPage=1)
		_DIFF_NumDifferences:=MethodDiff_d_CalcNumChanges(->DEMO_BackColors_al)
	Else 
		_DIFF_NumDifferences:=MethodDiff_d_CalcNumChanges(->DEMO_BackColors_ALT_al)
	End if 
	
	
	//   Mod: DB (03/29/2014)
	If (_DIFF_NumDifferences=0)
		OBJECT SET ENABLED:C1123(*; "BTN_CopyToMethod"; False:C215)
		OBJECT SET ENABLED:C1123(*; "BTN_CopyToDisk"; False:C215)
	End if 
	
	// Handle if method does not exist
	If (Not:C34($vb_MethodDoesExist))
		OBJECT SET ENABLED:C1123(*; "BTN_CopyToDisk"; False:C215)
		OBJECT SET TITLE:C194(*; "BTN_CopyToMethod"; "<-- Create")
		If (_DIFF_MethodName="[@form]/@")  // Cannot create if on a form
			OBJECT SET ENABLED:C1123(*; "BTN_CopyToMethod"; False:C215)
		End if 
	End if 
	
	// Handle if the file does not exist
	If (Not:C34($vb_FileDoesExist))
		OBJECT SET ENABLED:C1123(*; "BTN_CopyToMethod"; False:C215)
		OBJECT SET TITLE:C194(*; "BTN_CopyToDisk"; "Create -->")
	End if 
	
	// Always disabled (for now at least)
	OBJECT SET ENABLED:C1123(*; "BTN_CopyToDisk"; False:C215)
	
	BTN_Rescan:=0
End if 


// #### Ensure that the ListBox has it's columns sized nicely
If (Form event code:C388=On Load:K2:1) | (Form event code:C388=On Resize:K2:27)
	C_LONGINT:C283(_DIFF_ListBox_ExtraSpace)
	C_LONGINT:C283($vl_fixedWidth; $vl_variableWidth)
	$vl_fixedWidth:=LISTBOX Get column width:C834(*; "Column1")+LISTBOX Get column width:C834(*; "Column3")
	
	C_LONGINT:C283($vl_left; $vl_top; $vl_right; $vl_bottom; $vl_ListBoxWidth)
	OBJECT GET COORDINATES:C663(*; "DEMO_FileDiff_lb"; $vl_left; $vl_top; $vl_right; $vl_bottom)
	$vl_ListBoxWidth:=$vl_right-$vl_left
	
	If (Form event code:C388=On Load:K2:1)
		$vl_variableWidth:=LISTBOX Get column width:C834(*; "Column2")+LISTBOX Get column width:C834(*; "Column4")
		_DIFF_ListBox_ExtraSpace:=$vl_ListBoxWidth-($vl_variableWidth+$vl_fixedWidth)
	End if 
	
	// The amount of "space" that is left over for the two variable columns
	$vl_variableWidth:=$vl_ListBoxWidth-$vl_fixedWidth-_DIFF_ListBox_ExtraSpace
	
	C_LONGINT:C283($vl_FirstWidth; $vl_SecondWidth)
	$vl_FirstWidth:=Int:C8($vl_variableWidth/2)
	$vl_SecondWidth:=$vl_variableWidth-$vl_FirstWidth
	
	LISTBOX SET COLUMN WIDTH:C833(*; "Column2"; $vl_FirstWidth)
	LISTBOX SET COLUMN WIDTH:C833(*; "Column4"; $vl_SecondWidth)
	
	//   Mod: DB (03/29/2014) - Move the Rescan button to centre of listbox
	C_LONGINT:C283($vl_curCentre)
	OBJECT GET COORDINATES:C663(*; "BTN_Rescan"; $vl_left; $vl_top; $vl_right; $vl_bottom)
	$vl_curCentre:=$vl_left+(($vl_right-$vl_left)/2)
	OBJECT MOVE:C664(*; "BTN_Rescan"; 11+($vl_ListBoxWidth/2)-$vl_curCentre; 0)
	
	//   Mod: DB (03/29/2014) - Move the Rescan button to centre of listbox
	OBJECT GET COORDINATES:C663(*; "BTN_Rescan_Image"; $vl_left; $vl_top; $vl_right; $vl_bottom)
	$vl_curCentre:=$vl_left+(($vl_right-$vl_left)/2)
	OBJECT MOVE:C664(*; "BTN_Rescan_Image"; 11+($vl_ListBoxWidth/2)-$vl_curCentre; 0)
	
	//   Mod: DB (03/29/2014) - Move the Apply button
	OBJECT GET COORDINATES:C663(*; "BTN_CopyToMethod"; $vl_left; $vl_top; $vl_right; $vl_bottom)
	OBJECT MOVE:C664(*; "BTN_CopyToMethod"; ($vl_ListBoxWidth/2)-$vl_right-6; 0)
	OBJECT GET COORDINATES:C663(*; "BTN_CopyToDisk"; $vl_left; $vl_top; $vl_right; $vl_bottom)
	OBJECT MOVE:C664(*; "BTN_CopyToDisk"; ($vl_ListBoxWidth/2)-$vl_left+28; 0)
	
End if 