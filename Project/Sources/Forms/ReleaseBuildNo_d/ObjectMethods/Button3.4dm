C_POINTER:C301($vp_stringReleaseNo)
$vp_stringReleaseNo:=OBJECT Get data source:C1265(*; "string_releaseNo")

If ($vp_stringReleaseNo->="r1")
	BEEP:C151
Else 
	$vp_stringReleaseNo->:="r"+String:C10(Num:C11($vp_stringReleaseNo->)-1)
End if 
