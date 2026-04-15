//%attributes = {"invisible":true}
// Pref_SetEOL (EOLcharacters)
//
// DESCRIPTION
//   Sets the selected EOL characters
//
#DECLARE($eol : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	Case of 
		: ($1=Char:C90(Carriage return:K15:38))
			$eol:="CR"
			
		: ($1=Char:C90(Line feed:K15:40))
			$eol:="LF"
			
		: ($1=(Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)))
			$eol:="CRLF"
			
		Else 
			// Do a platform specific default
			If (Is macOS:C1572)
				$eol:="LF"
			Else 
				$eol:="CRLF"
			End if 
	End case 
	
	Pref_SetPrefString("EXPRT2File EOL Encoding"; $eol)
	
	var <>_EOL : Text
	<>_EOL:=""  // Forces a refresh
	<>_EOL:=Pref_GetEOL
End if 
