//%attributes = {"invisible":true}
// File_MakeNameWindowsSafe (inputFilePath) : safeFilePath
// File_MakeNameWindowsSafe (text) : text
//
// DESCRIPTION
//   Scans the inputed path and "encodes" the unsafe
//   characters for windows.
//
//   The keyboard characters that cannot be used in a 
//   Windows filename are:   \ / : * ? " < > |
//
C_TEXT:C284($1; $vt_inputFilePath)
C_TEXT:C284($0; $vt_safeFilePath)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/26/2013)
// ----------------------------------------------------

$vt_safeFilePath:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_inputFilePath:=$1
	
	If (Is Windows:C1573)
		C_TEXT:C284($vt_theChar)
		C_BOOLEAN:C305($vb_convertChar)
		C_LONGINT:C283($i)
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
			
			$vt_safeFilePath:=$vt_safeFilePath+$vt_theChar
		End for 
		
	Else 
		$vt_safeFilePath:=$1
	End if 
	
End if   // ASSERT
$0:=$vt_safeFilePath