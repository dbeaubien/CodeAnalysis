//%attributes = {"invisible":true}
// OT_PutText (objID; tag; value)
// OT_PutText (text; text; text)
// 
// DESCRIPTION
//   Put the text value into the mock object under tag
//
C_TEXT:C284($1; $xml_Ref)
C_TEXT:C284($2; $vt_tag)
C_TEXT:C284($3; $vt_value)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/11/2014)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$xml_Ref:=$1
	$vt_tag:=Replace string:C233("Tag_"+STR_Base64_Encode($2); "="; "")
	$vt_value:=$3
	
	DOM SET XML ELEMENT VALUE:C868($xml_Ref; "/OT_MockObject/"+$vt_tag; $vt_value)
End if   // ASSERT