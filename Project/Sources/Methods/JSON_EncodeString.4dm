//%attributes = {"invisible":true}
// JSON_EncodeString (srcString) : encodedString
// JSON_EncodeString (text) : text
// 
// DESCRIPTION
//   Encodes the following in the srcstring
//   \' Apostrophe or single quote
//   \" Double quote"
//   \t Tab
//   \n New line
//   \r Carriage return
//   \\ Backslash character
//
C_TEXT:C284($1; $vt_srcString)
C_TEXT:C284($2; $vt_encodedString)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/07/12)
// ----------------------------------------------------

$vt_encodedString:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_srcString:=$1
	
	C_TEXT:C284($theChar)
	C_LONGINT:C283($i)
	For ($i; 1; Length:C16($vt_srcString))
		$theChar:=$vt_srcString[[$i]]
		Case of 
			: ($theChar=Char:C90(Double quote:K15:41))
				$vt_encodedString:=$vt_encodedString+"\\"+$theChar
				
			: ($theChar=Char:C90(Tab:K15:37))
				$vt_encodedString:=$vt_encodedString+"\\t"
				
			: ($theChar=Char:C90(Line feed:K15:40))
				$vt_encodedString:=$vt_encodedString+"\\n"
				
			: ($theChar=Char:C90(Carriage return:K15:38))
				$vt_encodedString:=$vt_encodedString+"\\r"
				
			: ($theChar="\\")
				$vt_encodedString:=$vt_encodedString+"\\"+$theChar
				
			Else 
				$vt_encodedString:=$vt_encodedString+$theChar
		End case 
	End for 
	
End if   // ASSERT
$0:=$vt_encodedString