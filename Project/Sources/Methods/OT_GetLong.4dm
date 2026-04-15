//%attributes = {"invisible":true}
// OT_GetLong (objID; tag) : realNumber
// OT_GetLong (text; text) : Long
// 
// DESCRIPTION
//   Get the Long number from the mock object under tag
//
C_TEXT:C284($1; $xml_Ref)
var $2; $vt_tag : Text
var $0; $vr_longNumber : Integer
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/11/2014)
// ----------------------------------------------------

$vr_longNumber:=0
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$xml_Ref:=$1
	$vt_tag:=$2
	
	$vr_longNumber:=Num:C11(OT_GetText($xml_Ref; $vt_tag))
	
End if 
$0:=$vr_longNumber