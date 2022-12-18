//%attributes = {"invisible":true}
// (PM) STR_URLEncode
// Returns a URL encoded string
// $1 = String to encode
// $0 = Encoded string

C_TEXT:C284($1; $0; $input; $output; $validCharacters)
C_LONGINT:C283($position; $length; $byte)
C_BOOLEAN:C305($isSafe)

$input:=$1

// Fill an array with the characters which need no conversion
$validCharacters:="1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz:/.?=_-$(){}~&"
$length:=Length:C16($validCharacters)
ARRAY LONGINT:C221($al_SafeCharacters; $length)
For ($position; 1; $length)
	$al_SafeCharacters{$position}:=Character code:C91($validCharacters[[$position]])
End for 

// Convert the characters
$length:=Length:C16($input)
For ($position; 1; $length)
	
	$byte:=Character code:C91($input[[$position]])
	$isSafe:=(Find in array:C230($al_SafeCharacters; $byte)#-1)
	
	Case of 
		: ($isSafe)  // It's a safe character, append unaltered
			$output:=$output+Char:C90($byte)
			
			//: ($byte=32)  // It's a space, append a plus sign
			//$output:=$output+"+"
			
		Else   // It's an unsafe character, append as a hex string 
			$output:=$output+"%"+Substring:C12(String:C10($byte; "&x"); 5)
	End case 
	
	
End for 

$0:=$output
