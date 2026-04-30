//%attributes = {"invisible":true}
// File_MakeNameWindowsSafe (inputFilePath) : safeFilePath
//  (text) : text
//
// DESCRIPTION
//   Scans the inputed path and "encodes" the unsafe
//   characters for windows.
//
//   The keyboard characters that cannot be used in a 
//   Windows filename are:   \ / : * ? " < > |
//
#DECLARE($vt_inputFilePath : Text)->$vt_safeFilePath : Text
// ----------------------------------------------------
$vt_safeFilePath:=""

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	If (Is Windows:C1573)
		var $vt_theChar : Text
		var $vb_convertChar : Boolean
		var $i : Integer
		For ($i; 1; Length:C16($vt_inputFilePath))
			$vt_theChar:=$vt_inputFilePath[[$i]]
			
			$vb_convertChar:=True:C214
			Case of 
					//: ($vt_theChar="/")
				: ($vt_theChar="\\")
				: ($vt_theChar=":")
				: ($vt_theChar="*")
				: ($vt_theChar="?")
				: ($vt_theChar="\"")
				: ($vt_theChar="<")
				: ($vt_theChar=">")
				: ($vt_theChar="|")
				Else 
					$vb_convertChar:=False:C215
			End case 
			
			If ($vb_convertChar)
				$vt_theChar:="%"+Substring:C12(String:C10(Character code:C91($vt_theChar); "&x"); 5)
			End if 
			
			$vt_safeFilePath+=$vt_theChar
		End for 
		
	Else 
		$vt_safeFilePath:=$vt_inputFilePath
	End if 
	
End if 
