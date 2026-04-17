//%attributes = {"invisible":true}
// Str_DateTimeStamp () : dateTimeStampStr
//
// DESCRIPTION
//   Produces a date time stamp
//
#DECLARE()->$datetime_stamp : Text
// ----------------------------------------------------

$datetime_stamp:=Date2String(Current date:C33; "yyyy-mm-dd ")
$datetime_stamp+=Time2String(Current time:C178; "hh:mmampm")
