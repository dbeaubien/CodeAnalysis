//%attributes = {"invisible":true}
// OT_GetText (objID; tag) : value
// OT_GetText (text; text) : text
// 
// DESCRIPTION
//   Get the text value from the mock object under tag
//
C_TEXT:C284($1; $xml_Ref)
C_TEXT:C284($2; $vt_tag)
C_TEXT:C284($0; $vt_value)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/11/2014)
// ----------------------------------------------------

$vt_value:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$xml_Ref:=$1
	$vt_tag:=Replace string:C233("Tag_"+STR_Base64_Encode($2); "="; "")
	
	C_TEXT:C284($xml_foundRef; $vt_CDATA_value)
	$xml_foundRef:=DOM Find XML element:C864($xml_Ref; "/OT_MockObject/"+$vt_tag)
	If (OK=1)  // value was found?
		DOM GET XML ELEMENT VALUE:C731($xml_foundRef; $vt_value; $vt_CDATA_value)
		$vt_value:=$vt_value+$vt_CDATA_value
	End if 
	
End if   // ASSERT
$0:=$vt_value