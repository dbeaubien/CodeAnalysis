
Case of 
	: (Form event code:C388=On Load:K2:1)
		// Code to set values is in the "Revert" button
		
		
	: (Form event code:C388=On Unload:K2:2)
		C_POINTER:C301($vp_stringYear)
		$vp_stringYear:=OBJECT Get data source:C1265(*; "string_year")
		
		C_POINTER:C301($vp_stringReleaseNo)
		$vp_stringReleaseNo:=OBJECT Get data source:C1265(*; "string_releaseNo")
		
		C_POINTER:C301($vp_stringBuildNo)
		$vp_stringBuildNo:=OBJECT Get data source:C1265(*; "string_buildNo")
		
		BuildNo_SetBuildNo($vp_stringYear->; $vp_stringReleaseNo->; $vp_stringBuildNo->)
		
		
End case 