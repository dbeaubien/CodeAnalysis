//%attributes = {"invisible":true}
// Utility_MakeTextStyleSafe (srcText) : resultText
// Utility_MakeTextStyleSafe (text) : text
//
// DESCRIPTION
//   Takes the input text and converts characters to be "style" safe.
//    "<" --> "&lt;"
//    ">" --> "&gt;"
//    "&" --> "&amp;"
//
C_TEXT:C284($1; $vt_srcText)
C_TEXT:C284($0; $vt_resultText)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (11/24/2013)
// ----------------------------------------------------

$vt_resultText:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_srcText:=$1
	
	If ($vt_srcText="<span@")
		$vt_resultText:=$vt_srcText
		
	Else 
		$vt_resultText:=Replace string:C233($vt_srcText; "&"; "&amp;")
		$vt_resultText:=Replace string:C233($vt_resultText; "<"; "&lt;")
		$vt_resultText:=Replace string:C233($vt_resultText; ">"; "&gt;")
	End if 
	
End if   // ASSERT
$0:=$vt_resultText
