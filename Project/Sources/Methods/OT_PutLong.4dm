//%attributes = {"invisible":true}
// OT_PutLong (objID; tag; longValue)
// OT_PutLong (text; text; longint)
// 
// DESCRIPTION
//   Put the long number into the mock object under tag
//
C_TEXT:C284($1; $xml_Ref)
C_TEXT:C284($2; $vt_tag)
C_LONGINT:C283($3; $vr_longintNumber)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/11/2014)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$xml_Ref:=$1
	$vt_tag:=$2
	$vr_longintNumber:=$3
	
	OT_PutText($xml_Ref; $vt_tag; String:C10($vr_longintNumber))
End if   // ASSERT