//   Mod: DB (05/14/2014)

If (Form event code:C388=On Clicked:K2:4) & (_DIFF_NumDifferences>0)
	var $vl_vertPosition : Integer
	OBJECT GET SCROLL POSITION:C1114(DEMO_FileDiff_ALT_lb; $vl_vertPosition)
	
	var $vl_noChangeColour; $vl_curColour : Integer
	$vl_noChangeColour:=0x00FFFFFF
	
	If ($vl_vertPosition>1)
		$vl_vertPosition:=$vl_vertPosition-1  // Force at least one scroll position of movement
		
		// Get to top of current colour
		var $vb_done : Boolean
		$vl_curColour:=DEMO_BackColors_ALT_al{$vl_vertPosition}
		$vb_done:=False:C215
		While ($vl_vertPosition>1) & (Not:C34($vb_done))
			If ($vl_curColour#DEMO_BackColors_ALT_al{$vl_vertPosition-1})
				$vb_done:=True:C214
			Else 
				$vl_vertPosition:=$vl_vertPosition-1
			End if 
		End while 
		
		
		// If we are at the top of "no change", then move to the top of the previous change block
		If ($vl_vertPosition>1)
			If (DEMO_BackColors_ALT_al{$vl_vertPosition}=$vl_noChangeColour)
				$vl_vertPosition:=$vl_vertPosition-1  // Force at least one scroll position of movement
				$vl_curColour:=DEMO_BackColors_ALT_al{$vl_vertPosition}
				
				// Get to top of current colour
				$vb_done:=False:C215
				While ($vl_vertPosition>1) & (Not:C34($vb_done))
					If ($vl_curColour#DEMO_BackColors_ALT_al{$vl_vertPosition-1})
						$vb_done:=True:C214
					Else 
						$vl_vertPosition:=$vl_vertPosition-1
					End if 
				End while 
				
			End if 
		End if 
		
		OBJECT SET SCROLL POSITION:C906(DEMO_FileDiff_ALT_lb; $vl_vertPosition; *)
	End if 
	
End if 