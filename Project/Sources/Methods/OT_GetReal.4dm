//%attributes = {"invisible":true}
// OT_GetReal (objID; tag) : realNumber
// 
// DESCRIPTION
//   Get the real number from the mock object under tag
//
#DECLARE($xml_Ref : Text; $vt_tag : Text)->$vr_realNumber : Real
// ----------------------------------------------------
$vr_realNumber:=0

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$vr_realNumber:=Num:C11(OT_GetText($xml_Ref; $vt_tag))
End if 
