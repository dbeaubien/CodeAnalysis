
Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(at_EOL_encoding; 3)
		ARRAY TEXT:C222(at_EOL_chars; 3)
		at_EOL_encoding{1}:="CR"  // Default that comes out of 4D
		at_EOL_chars{1}:=Char:C90(Carriage return:K15:38)
		at_EOL_encoding{2}:="LF"
		at_EOL_chars{2}:=Char:C90(Line feed:K15:40)
		at_EOL_encoding{3}:="CRLF"
		at_EOL_chars{3}:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		at_EOL_encoding:=Find in array:C230(at_EOL_chars; Pref_GetEOL)
		If (at_EOL_encoding<1)
			Pref_SetEOL(Char:C90(Carriage return:K15:38))
			at_EOL_encoding:=1
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		If (at_EOL_encoding>0)
			Pref_SetEOL(at_EOL_chars{at_EOL_encoding})
		Else 
			at_EOL_encoding:=Find in array:C230(at_EOL_chars; Pref_GetEOL)
		End if 
		
End case 