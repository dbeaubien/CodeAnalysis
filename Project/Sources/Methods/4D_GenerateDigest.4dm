//%attributes = {"invisible":true}
// 4D_GenerateDigest (sourceText) : MD5digest
// 
// DESCRIPTION
//   Returns a MD5 digest of the source text
//
#DECLARE($sourceTxt : Text)->$digest : Text
// ----------------------------------------------------
$digest:=""

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$digest:=Generate digest:C1147($sourceTxt; MD5 digest:K66:1)
End if 
