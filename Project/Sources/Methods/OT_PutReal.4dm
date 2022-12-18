//%attributes = {"invisible":true}
// OT_PutReal (objID; tag; realValue)
// OT_PutReal (text; text; real)
// 
// DESCRIPTION
//   Put the real number into the mock object under tag
//
C_TEXT:C284($1; $xml_Ref)
C_TEXT:C284($2; $vt_tag)
C_REAL:C285($3; $vr_realNumber)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/11/2014)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$xml_Ref:=$1
	$vt_tag:=$2
	$vr_realNumber:=$3
	
	OT_PutText($xml_Ref; $vt_tag; String:C10($vr_realNumber))
End if   // ASSERT