//%attributes = {"invisible":true,"preemptive":"capable"}
// STR_Remove_Leading_Spaces

C_TEXT:C284($0; $1)
C_BOOLEAN:C305($done)
If (Length:C16($1)>0)
	If ($1[[1]]#" ")
		$0:=$1
	Else 
		Repeat 
			If ($1[[1]]=" ")
				$1:=Delete string:C232($1; 1; 1)
			Else 
				$done:=True:C214
			End if 
		Until ($done) | ($1="")
		
		$0:=$1
	End if 
End if 