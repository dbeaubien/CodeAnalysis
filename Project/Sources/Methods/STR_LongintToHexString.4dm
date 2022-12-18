//%attributes = {"invisible":true}
// STR_LongintToHexString (number; minSpaces) : hexString
// STR_LongintToHexString (longint; longint) : text
// 
// DESCRIPTION
//   Converts the passed longint into a hex string.
//
C_LONGINT:C283($1; $vl_sourceNumber)
C_LONGINT:C283($2; $vl_minSpaces)
C_TEXT:C284($0; $vt_hexString)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/01/12)
// ----------------------------------------------------

$vt_hexString:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$vl_sourceNumber:=$1
	$vl_minSpaces:=$2
	
	C_TEXT:C284($hexValues)
	$hexValues:="0123456789ABCDEF"
	
	// Grab the first byte
	C_LONGINT:C283($vl_front; $vl_back; $vl_byte)
	While ($vl_sourceNumber>0)
		C_LONGINT:C283($vl_byte)
		$vl_byte:=$vl_sourceNumber & 0x00FF
		
		$vl_front:=$vl_byte >> 4
		$vl_back:=$vl_byte & 0x000F
		
		$vt_hexString:=$hexValues[[$vl_front+1]]+$hexValues[[$vl_back+1]]+$vt_hexString
		
		$vl_sourceNumber:=$vl_sourceNumber >> 8
	End while 
	
	If (Length:C16($vt_hexString)<$vl_minSpaces)
		$vl_minSpaces:=$vl_minSpaces-Length:C16($vt_hexString)
		$vt_hexString:=("0"*$vl_minSpaces)+$vt_hexString
	End if 
	
End if   // ASSERT
$0:=$vt_hexString