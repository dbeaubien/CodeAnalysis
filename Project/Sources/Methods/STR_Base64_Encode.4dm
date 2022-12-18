//%attributes = {"invisible":true}
// Method: STR_Base64_Encode (text) : text

// Convert an ascii string into a base64 string
// Based on RFC 1521 (http://www.freesoft.org/Connected/RFC/1521/7.html)

// 2000/11/12 modified it so that is much more efficient.


// • must convert all CR to CRLF


C_TEXT:C284($0; $encoded)  //$0 contains a base64 encoded string
C_TEXT:C284($1; $input)  //$1 contains an ascii string string
$input:=$1

C_TEXT:C284($codedCharacters)
$codedCharacters:="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="

// The size of the input must be a multiple of 3 characters.
// Figure out how many are left if div by 3.
C_LONGINT:C283($remainder)
$remainder:=Mod:C98(Length:C16($input); 3)

//translate the ascii string into a binary string and then encode it
//translate each 6 bits packet from the previous string into
//base64 chars
$encoded:=""
C_LONGINT:C283($i; $group1; $group2; $group3; $group4)
C_TEXT:C284($inputChars_24bits)
For ($i; 1; Length:C16($input); 3)
	// grab 3 characters, pad an extra two just in case at the end of the string  
	$inputChars_24bits:=Substring:C12($input; $i; 3)+Char:C90(0)+Char:C90(0)
	
	// convert into 4 6bit chars
	$group1:=Character code:C91($inputChars_24bits[[1]]) >> 2  // get high 6 bits
	
	$group2:=Character code:C91($inputChars_24bits[[1]]) & (0x0003)  // get 2 low bits of char 1
	$group2:=(($group2) << 4)+(Character code:C91($inputChars_24bits[[2]]) >> 4)  // get 4 high bits of char 2
	
	$group3:=Character code:C91($inputChars_24bits[[2]]) & (0x000F)  // get 4 low bits of char 2
	$group3:=(($group3) << 2)+(Character code:C91($inputChars_24bits[[3]]) >> 6)  // get 2 high bits of char 3
	
	$group4:=Character code:C91($inputChars_24bits[[3]]) & (0x003F)  // get 4 low bits of char 2
	
	// write out the encoded characters
	$encoded:=$encoded+$codedCharacters[[$group1+1]]
	$encoded:=$encoded+$codedCharacters[[$group2+1]]
	If (($i+3)>Length:C16($input))
		If ($remainder=1)
			$group3:=64  // reference the pad character
			$group4:=64
		Else 
			If ($remainder=2)
				$group4:=64  // reference the pad character
			End if 
		End if 
	End if 
	$encoded:=$encoded+$codedCharacters[[$group3+1]]
	$encoded:=$encoded+$codedCharacters[[$group4+1]]
End for 

$0:=$encoded