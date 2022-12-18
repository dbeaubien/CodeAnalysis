//%attributes = {"invisible":true}
// OT_GetReal (objID; tag) : realNumber
// OT_GetText (text; text) : real
// 
// DESCRIPTION
//   Get the real number from the mock object under tag
//
C_TEXT:C284($1; $xml_Ref)
C_TEXT:C284($2; $vt_tag)
C_REAL:C285($0; $vr_realNumber)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/11/2014)
// ----------------------------------------------------

$vr_realNumber:=0
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$xml_Ref:=$1
	$vt_tag:=$2
	
	$vr_realNumber:=Num:C11(OT_GetText($xml_Ref; $vt_tag))
	
End if   // ASSERT
$0:=$vr_realNumber