//%attributes = {"invisible":true}
// STR_LongintToHexString (number; minSpaces) : hexString
// 
// DESCRIPTION
//   Converts the passed longint into a hex string.
//
#DECLARE($vl_sourceNumber : Integer; $vl_minSpaces : Integer)->$vt_hexString : Text
// ----------------------------------------------------
$vt_hexString:=""

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	var $hexValues : Text
	$hexValues:="0123456789ABCDEF"
	
	// Grab the first byte
	var $vl_front; $vl_back; $vl_byte : Integer
	While ($vl_sourceNumber>0)
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
	
End if 
