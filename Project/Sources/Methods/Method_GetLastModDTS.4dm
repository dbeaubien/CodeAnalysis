//%attributes = {"invisible":true}
// Method_GetLastModDTS (methodPath) : lastModDTS
// Method_GetLastModDTS (text) : longint
// 
// DESCRIPTION
//   Returns the a DTS value that is the last time
//   the specificed method was modified.
//
C_TEXT:C284($1; $methodPath)
C_LONGINT:C283($0; $lastModDTS)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (08/24/2017)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

$lastModDTS:=0
$methodPath:=$1

C_DATE:C307($vd_methodModDate)
C_TIME:C306($vh_methodModTime)

METHOD GET MODIFICATION DATE:C1170($methodPath; $vd_methodModDate; $vh_methodModTime; *)
$lastModDTS:=TS_FromDateTime($vd_methodModDate; $vh_methodModTime)

$0:=$lastModDTS