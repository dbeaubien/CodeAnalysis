//%attributes = {"invisible":true}
// (PM) STR_URLDecode
// Returns a URL decoded string
// $1 = String to decode
// $0 = Decoded string

C_TEXT:C284($1; $0; $input; $output; $hexValues)
C_LONGINT:C283($position; $value)

$input:=$1
$hexValues:="123456789ABCDEF"

For ($position; 1; Length:C16($input))
	
	Case of 
		: ($input[[$position]]="+")
			$output:=$output+" "
			
		: ($input[[$position]]="%")
			$value:=Position:C15(Substring:C12($input; $position+1; 1); $hexValues)*16
			$value:=$value+Position:C15(Substring:C12($input; $position+2; 1); $hexValues)
			$output:=$output+Char:C90($value)
			$position:=$position+2
		Else 
			$output:=$output+$input[[$position]]
	End case 
	
End for 

$0:=$output
