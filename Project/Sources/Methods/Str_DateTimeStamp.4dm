//%attributes = {"invisible":true}
// Str_DateTimeStamp () : dateTimeStampStr
// Str_DateTimeStamp () : text
//
// DESCRIPTION
//   Produces a date time stamp
//
C_TEXT:C284($0; $vt_dateTimeStamp)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (02/25/2017)
// ----------------------------------------------------

$vt_dateTimeStamp:=Date2String(Current date:C33; "yyyy-mm-dd ")
$vt_dateTimeStamp:=$vt_dateTimeStamp+Time2String(Current time:C178; "hh:mmampm")
$0:=$vt_dateTimeStamp