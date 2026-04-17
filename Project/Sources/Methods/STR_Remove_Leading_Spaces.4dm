//%attributes = {"invisible":true,"preemptive":"capable"}
// STR_Remove_Leading_Spaces
#DECLARE($input : Text)->$output : Text

var $done : Boolean
If (Length:C16($input)>0)
	If ($input[[1]]#" ")
		$output:=$input
	Else 
		Repeat 
			If ($input[[1]]=" ")
				$input:=Delete string:C232($input; 1; 1)
			Else 
				$done:=True:C214
			End if 
		Until ($done) | ($input="")
		
		$output:=$input
	End if 
End if 