//%attributes = {"invisible":true}
// Pref_SetEOL (EOLcharacters)
// Pref_SetEOL (text)
//
// DESCRIPTION
//   Sets the selected EOL characters
//
C_TEXT:C284($1; $vt_newEOL)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (02/17/2014)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_newEOL:=$1
	
	Case of 
		: ($1=Char:C90(Carriage return:K15:38))
			$vt_newEOL:="CR"
		: ($1=Char:C90(Line feed:K15:40))
			$vt_newEOL:="LF"
		: ($1=(Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)))
			$vt_newEOL:="CRLF"
			
		Else 
			// Do a platform specific default
			If (Is macOS:C1572)
				$vt_newEOL:="LF"
			Else 
				$vt_newEOL:="CRLF"
			End if 
	End case 
	
	Pref_SetPrefString("EXPRT2File EOL Encoding"; $vt_newEOL)
	
	C_TEXT:C284(<>_EOL)
	<>_EOL:=""  // Forces a refresh
	<>_EOL:=Pref_GetEOL
End if   // ASSERT
