//%attributes = {"invisible":true}
// Utility_MakeTextStyleSafe (srcText) : resultText
//
// DESCRIPTION
//   Takes the input text and converts characters to be "style" safe.
//    "<" --> "&lt;"
//    ">" --> "&gt;"
//    "&" --> "&amp;"
//
#DECLARE($vt_srcText : Text)->$vt_resultText : Text
// ----------------------------------------------------

$vt_resultText:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	If ($vt_srcText="<span@")
		$vt_resultText:=$vt_srcText
		
	Else 
		$vt_resultText:=Replace string:C233($vt_srcText; "&"; "&amp;")
		$vt_resultText:=Replace string:C233($vt_resultText; "<"; "&lt;")
		$vt_resultText:=Replace string:C233($vt_resultText; ">"; "&gt;")
	End if 
	
End if 
