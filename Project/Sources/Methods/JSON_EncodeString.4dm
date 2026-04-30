//%attributes = {"invisible":true}
// JSON_EncodeString (srcString) : encodedString
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
#DECLARE($input : Text)->$encoded_string : Text
// ----------------------------------------------------
$encoded_string:=""

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	var $theChar : Text
	var $i : Integer
	For ($i; 1; Length:C16($input))
		$theChar:=$input[[$i]]
		Case of 
			: ($theChar=Char:C90(Double quote:K15:41))
				$encoded_string+="\\"+$theChar
				
			: ($theChar=Char:C90(Tab:K15:37))
				$encoded_string+="\\t"
				
			: ($theChar=Char:C90(Line feed:K15:40))
				$encoded_string+="\\n"
				
			: ($theChar=Char:C90(Carriage return:K15:38))
				$encoded_string+="\\r"
				
			: ($theChar="\\")
				$encoded_string+="\\"+$theChar
				
			Else 
				$encoded_string+=$theChar
		End case 
	End for 
	
End if 
