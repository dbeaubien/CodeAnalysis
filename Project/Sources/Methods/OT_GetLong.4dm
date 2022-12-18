//%attributes = {"invisible":true}
// OT_GetLong (objID; tag) : realNumber
// OT_GetLong (text; text) : Long
// 
// DESCRIPTION
//   Get the Long number from the mock object under tag
//
C_TEXT:C284($1; $xml_Ref)
C_TEXT:C284($2; $vt_tag)
C_LONGINT:C283($0; $vr_longNumber)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/11/2014)
// ----------------------------------------------------

$vr_longNumber:=0
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$xml_Ref:=$1
	$vt_tag:=$2
	
	$vr_longNumber:=Num:C11(OT_GetText($xml_Ref; $vt_tag))
	
End if   // ASSERT
$0:=$vr_longNumber