//%attributes = {"invisible":true}
// OT_GetLong (objID; tag) : realNumber
// 
// DESCRIPTION
//   Get the Long number from the mock object under tag
//
#DECLARE($xml_Ref : Text; $vt_tag : Text)->$vr_longNumber : Integer
// ----------------------------------------------------
$vr_longNumber:=0

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$vr_longNumber:=Num:C11(OT_GetText($xml_Ref; $vt_tag))
End if 
