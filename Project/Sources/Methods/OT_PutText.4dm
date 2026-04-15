//%attributes = {"invisible":true}
// OT_PutText (objID; tag; value)
// 
// DESCRIPTION
//   Put the text value into the mock object under tag
//
#DECLARE($xml_Ref : Text; $vt_tag : Text; $vt_value : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$vt_tag:=Replace string:C233("Tag_"+STR_Base64_Encode($vt_tag); "="; "")
	
	DOM SET XML ELEMENT VALUE:C868($xml_Ref; "/OT_MockObject/"+$vt_tag; $vt_value)
End if 