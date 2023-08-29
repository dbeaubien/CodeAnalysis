//%attributes = {"invisible":true,"preemptive":"capable"}
// UTL_lowerCamelCase
#DECLARE($vt_textIn : Text)->$vt_textOut : Text
$vt_textOut:=""

If (Length:C16($vt_textIn)>0)
	
	var $c_explode : Collection
	$c_explode:=Split string:C1554(Replace string:C233($vt_textIn; "_"; " "; *)\
		; " "\
		; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	
	var $vt_part : Text
	For each ($vt_part; $c_explode)
		If (Length:C16($vt_textOut)=0)
			$vt_textOut:=Lowercase:C14($vt_part)
		Else 
			$vt_textOut:=$vt_textOut+Uppercase:C13($vt_part[[1]])+Lowercase:C14(Substring:C12($vt_part; 2))
		End if 
	End for each 
	
End if 
