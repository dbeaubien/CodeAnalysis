// Added: Dani Beaubien (09/27/2013) - 

If (Form event code:C388=On Clicked:K2:4) & (_DIFF_NumDifferences>0)
	
	C_LONGINT:C283($vl_vertPosition)
	OBJECT GET SCROLL POSITION:C1114(DEMO_FileDiff_lb; $vl_vertPosition)
	
	// Is the top row a "diff"?
	C_BOOLEAN:C305($vb_outOfDiff)
	$vb_outOfDiff:=False:C215
	If (DEMO_Styles_al{$vl_vertPosition}#Italic:K14:3)
		$vb_outOfDiff:=True:C214
	End if 
	
	
	C_BOOLEAN:C305($vb_done)
	If ($vl_vertPosition>1)
		$vb_done:=False:C215
		Repeat 
			$vl_vertPosition:=$vl_vertPosition-1  // Move to next row
			Case of 
				: ($vl_vertPosition<1)  // at end
					OBJECT GET SCROLL POSITION:C1114(DEMO_FileDiff_lb; $vl_vertPosition)  // restore our position
					$vb_done:=True:C214
					//BEEP
					
				: ($vb_outOfDiff) & ((DEMO_File1LineNo_al{$vl_vertPosition}=0) | (DEMO_File2LineNo_al{$vl_vertPosition}=0))
					$vb_done:=True:C214
					
				: ($vb_outOfDiff=False:C215)  // Need to get to where we are out of the current diff
					// Is the current row a "diff"?
					If (DEMO_Styles_al{$vl_vertPosition}#Italic:K14:3)
						$vb_outOfDiff:=True:C214
					End if 
					
				: (DEMO_Styles_al{$vl_vertPosition}=Italic:K14:3)  // Is a diff line
					$vb_done:=True:C214
					
				Else 
					// Still not in a "DIFF"
			End case 
		Until ($vb_done)
		
		// Go to the top of the item
		While ($vl_vertPosition>1) & (DEMO_Styles_al{$vl_vertPosition-1}=Italic:K14:3)
			$vl_vertPosition:=$vl_vertPosition-1
		End while 
		
		OBJECT SET SCROLL POSITION:C906(DEMO_FileDiff_lb; $vl_vertPosition; *)
	End if 
	
End if 