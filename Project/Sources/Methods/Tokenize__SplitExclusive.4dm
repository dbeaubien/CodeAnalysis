//%attributes = {"invisible":true,"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Dani Beaubien
// Date and time: 02/27/12, 17:34:22
// ----------------------------------------------------
// Method: Tokenize__SplitExclusive
// Description
//   Tokenizes the input line on the provided patter. The tokens
//   are appended to the passed array.
//
// Parameters
var $1; $pattern : Text
var $2; $localLine : Text
var $3; $ap_values : Pointer
// ----------------------------------------------------

$pattern:=$1
$localLine:=$2
$ap_values:=$3

$localLine:=$localLine+" "

var $start; $pos; $len; $index : Integer
var $localLine; $s : Text
var $done : Boolean

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