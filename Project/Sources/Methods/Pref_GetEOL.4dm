//%attributes = {"invisible":true}
// Pref_GetEOL () : EOLcharacters
// Pref_GetEOL () : text
//
// DESCRIPTION
//   Returns the selected EOL characters
//
C_TEXT:C284($0; <>_EOL)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (02/17/2014)
// ----------------------------------------------------

If (<>_EOL="")
	
	// Do a platform specific default
	C_TEXT:C284($vt_default)
	If (Is macOS:C1572)
		$vt_default:="LF"
	Else 
		$vt_default:="CRLF"
	End if 
	
	<>_EOL:=Pref_GetPrefString("EXPRT2File EOL Encoding"; $vt_default)
	
	Case of 
		: (<>_EOL="CR")
			<>_EOL:=Char:C90(Carriage return:K15:38)
		: (<>_EOL="LF")
			<>_EOL:=Char:C90(Line feed:K15:40)
		: (<>_EOL="CRLF")
			<>_EOL:=(Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40))
		Else 
			<>_EOL:=Char:C90(Carriage return:K15:38)
	End case 
End if 
$0:=<>_EOL