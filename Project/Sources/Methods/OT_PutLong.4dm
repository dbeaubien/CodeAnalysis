//%attributes = {"invisible":true}
// OT_PutLong (objID; tag; longValue)
// 
// DESCRIPTION
//   Put the long number into the mock object under tag
//
#DECLARE($xml_Ref : Text; $vt_tag : Text; $vr_longintNumber : Integer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	OT_PutText($xml_Ref; $vt_tag; String:C10($vr_longintNumber))
End if 