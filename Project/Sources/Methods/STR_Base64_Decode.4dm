//%attributes = {"invisible":true}
// Method: STR_Base64_Decode (encoded text) : decoded text

//convert a base64 encoded string into an ascii string
//Serge Glickmann, AGF.SI-DT/NTech (glickma@agf.fr)
//based on RFC 1521 (http://www.freesoft.org/Connected/RFC/1521/7.html)

// ITK_B642Text ()

C_TEXT:C284($0; $result)
$result:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	C_TEXT:C284($1; $input)
	$input:=Replace string:C233($1; "="; "")  //the "=" char is a padding char
	
	C_TEXT:C284($output)
	$output:=""
	
	C_LONGINT:C283($i; $j; $x; $ascii; $base64; $quotient; $divider)
	$x:=Length:C16($input)
	
	For ($i; 1; $x)  //convert all chars from the string into ascii values
		$ascii:=Character code:C91($input[[$i]])
		Case of 
			: ($ascii=43)  //the ascii code of the base64 char
				$base64:=62  //the base64 corresponding code
			: ($ascii=47)
				$base64:=63
			: ($ascii<58)
				$base64:=$ascii+4
			: ($ascii<91)
				$base64:=$ascii-65
			: ($ascii<123)
				$base64:=$ascii-71
		End case 
		$divider:=32
		For ($j; 1; 6)  //convert the base64 code into binary
			$quotient:=$base64\$divider
			$base64:=$base64-($quotient*$divider)
			$output:=$output+String:C10($quotient)
			$divider:=$divider\2
		End for 
	End for 
	
	$output:=Substring:C12($output; 1; (($x*6)\8)*8)  //you get a string of 8 bits chars
	For ($i; 1; Length:C16($output); 8)  //last "0" are padding bits
		$ascii:=(Num:C11($output[[$i]])*128)+(Num:C11($output[[$i+1]])*64)  //convert 8 bits into ascii chars
		$ascii:=$ascii+(Num:C11($output[[$i+2]])*32)+(Num:C11($output[[$i+3]])*16)
		$ascii:=$ascii+(Num:C11($output[[$i+4]])*8)+(Num:C11($output[[$i+5]])*4)
		$ascii:=$ascii+(Num:C11($output[[$i+6]])*2)+Num:C11($output[[$i+7]])
		$result:=$result+Char:C90($ascii)
	End for 
	
End if   // ASSERT

$0:=$result