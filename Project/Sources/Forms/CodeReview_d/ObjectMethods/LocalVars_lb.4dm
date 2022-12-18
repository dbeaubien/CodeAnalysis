Case of 
	: (Form event code:C388=On Clicked:K2:4)  // Highlight the rows where the variable appears
		C_TEXT:C284($vt_varPositions)
		If (at_LocalVarsUsed>0)
			$vt_varPositions:=at_LocalVarsPositions{at_LocalVarsUsed}
		Else 
			$vt_varPositions:=";"
		End if 
		
		ARRAY LONGINT:C221(DEMO_FontColors_al; Size of array:C274(DEMO_File1_at))
		ARRAY LONGINT:C221(DEMO_BackColors_al; Size of array:C274(DEMO_File1_at))
		ARRAY LONGINT:C221(DEMO_Styles_al; Size of array:C274(DEMO_File1_at))
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274(DEMO_FontColors_al))
			If (Position:C15(";"+String:C10($i)+";"; $vt_varPositions)>0)  // Is this row in the var?
				DEMO_BackColors_al{$i}:=0x00AFFFAF  // no change
			Else 
				DEMO_BackColors_al{$i}:=0x00FFFFFF  // no change
			End if 
		End for 
		
		
End case 