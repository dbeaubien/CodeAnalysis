//%attributes = {"invisible":true}
// 4D_GenerateDigest (sourceText) : MD5digest
// 4D_GenerateDigest (text) : text
// 
// DESCRIPTION
//   Returns a MD5 digest of the source text
//
C_TEXT:C284($1; $sourceTxt)
C_TEXT:C284($0; $digest)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/29/13)
// ----------------------------------------------------

$digest:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$sourceTxt:=$1
	
	$digest:=Generate digest:C1147($sourceTxt; MD5 digest:K66:1)
End if 
$0:=$digest