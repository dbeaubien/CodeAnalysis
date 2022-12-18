//%attributes = {"invisible":true}

// STR_Remove_Trailing_Spaces

C_TEXT:C284($0; $1)
C_LONGINT:C283($i)

If (Length:C16($1)>0)
	If ($1#"@ ")
		$0:=$1
	Else 
		For ($i; Length:C16($1); 1; -1)  //    Loop from end of string to beginning
			If ($1[[$i]]#" ")  //    If it is -NOT- a space, then
				$i:=-$i  //    force the loop to end (remember the spot)
			End if 
		End for 
		$0:=Delete string:C232($1; -$i; Length:C16($1))  //    Delete the spaces
	End if 
End if 