//%attributes = {"invisible":true,"preemptive":"capable"}
// Tokenize__SplitExclusive
//
// Description
//   Tokenizes the input line on the provided patter. The tokens
//   are appended to the passed array.
//
#DECLARE($pattern : Text; $localLine : Text; $ap_values : Pointer)
// ----------------------------------------------------

$localLine:=$localLine+" "

var $s : Text
var $done : Boolean
var $start; $pos; $len; $index : Integer

$start:=1
$index:=0
$done:=False:C215
Repeat 
	If (Match regex:C1019($pattern; $localLine; $start; $pos; $len))
		$start:=$pos+$len
		$index:=$index+1
		
		$s:=Substring:C12($localLine; $pos; $len-1)  // strip off the white space as well
		If ($len>0)
			APPEND TO ARRAY:C911($ap_values->; $s)
		End if 
		
	Else 
		$done:=True:C214
	End if 
Until ($done)