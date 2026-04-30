//%attributes = {"invisible":true}
// Method_GetLastModDTS (methodPath) : lastModDTS
// 
// DESCRIPTION
//   Returns the a DTS value that is the last time
//   the specificed method was modified.
//
#DECLARE($methodPath : Text)->$lastModDTS : Integer
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$lastModDTS:=0

var $vd_methodModDate : Date
var $vh_methodModTime : Time

METHOD GET MODIFICATION DATE:C1170($methodPath; $vd_methodModDate; $vh_methodModTime; *)
$lastModDTS:=TS_FromDateTime($vd_methodModDate; $vh_methodModTime)
