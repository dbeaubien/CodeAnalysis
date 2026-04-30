//%attributes = {"invisible":true}
// OT_GetText (objID; tag) : value
// 
// DESCRIPTION
//   Get the text value from the mock object under tag
//
#DECLARE($xml_Ref : Text; $vt_tag : Text)->$vt_value : Text
// ----------------------------------------------------

$vt_value:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$vt_tag:=Replace string:C233("Tag_"+STR_Base64_Encode($vt_tag); "="; "")
	
	var $xml_foundRef; $vt_CDATA_value : Text
	$xml_foundRef:=DOM Find XML element:C864($xml_Ref; "/OT_MockObject/"+$vt_tag)
	If (OK=1)  // value was found?
		DOM GET XML ELEMENT VALUE:C731($xml_foundRef; $vt_value; $vt_CDATA_value)
		$vt_value:=$vt_value+$vt_CDATA_value
	End if 
	
End if 
