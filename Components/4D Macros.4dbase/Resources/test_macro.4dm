//%attributes = {}
#DECLARE() : Boolean

var $fullMethod : Text
GET MACRO PARAMETER:C997(Full method text:K5:17; $fullMethod)

var $highlighted
GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $highlighted)

var $withSelection : Boolean:=Length:C16($highlighted)>0


// YOUR CODE HERE


If ($withSelection)
	
	SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $highlighted)
	
Else 
	
	SET MACRO PARAMETER:C998(Full method text:K5:17; $fullMethod)
	
End if 

return True:C214