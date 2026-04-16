//%attributes = {"invisible":true}
// OT_PutReal (objID; tag; realValue)
// 
// DESCRIPTION
//   Put the real number into the mock object under tag
//
#DECLARE($xml_Ref : Text; $vt_tag : Text; $vr_realNumber : Real)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$xml_Ref:=$1
	$vt_tag:=$2
	$vr_realNumber:=$3
	
	OT_PutText($xml_Ref; $vt_tag; String:C10($vr_realNumber))
End if 