// Added: Dani Beaubien (09/27/2013) - 

If (Form event code:C388=On Clicked:K2:4)
	
	C_LONGINT:C283($vl_vertPosition)
	OBJECT GET SCROLL POSITION:C1114(DEMO_FileDiff_ALT_lb; $vl_vertPosition)
	
	If ($vl_vertPosition>1)
		OBJECT SET SCROLL POSITION:C906(DEMO_FileDiff_ALT_lb; $vl_vertPosition-1; *)
	End if 
End if 