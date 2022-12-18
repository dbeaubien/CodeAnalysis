//%attributes = {"invisible":true,"shared":true,"preemptive":"incapable"}
// BuildNo_GetBuildNo_CodeAnalysis () : buildNoObj
// BuildNo_GetBuildNo_CodeAnalysis () : object
// 
// DESCRIPTION
//   Returns a build no object or the component.
//   For example: {"releaseYear":"2017","releaseNo":"r1","buildNo":"20170529","versionShort":"2017.r1","versionLong":"2017.r1 (build 20170529)"}
//
//   NOTE: Cannot be run in a pre-emptive process.
//
C_OBJECT:C1216($0; $vo_buildNoObj)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (05/29/2017)
// ----------------------------------------------------

ARRAY TEXT:C222($at_buildNo; 0)
LIST TO ARRAY:C288("BuildNo"; $at_buildNo)
Array_SetSize(1; ->$at_buildNo)  // Make sure there is at least one element

C_TEXT:C284($vt_value)
$vt_value:=$at_buildNo{1}

If ($vt_value#"") & ($vt_value="{@")
	$vo_buildNoObj:=JSON Parse:C1218($vt_value)
Else 
	$vo_buildNoObj:=New object:C1471
	$vo_buildNoObj.releaseYear:=String:C10(Year of:C25(Current date:C33))
	$vo_buildNoObj.releaseNo:="r1"
	$vo_buildNoObj.buildNo:=Date2String(Current date:C33; "yyyymmdd")
	$vo_buildNoObj.versionShort:=String:C10(Year of:C25(Current date:C33))+".r1"
	$vo_buildNoObj.versionLong:=String:C10(Year of:C25(Current date:C33))+".r1 (build "+Date2String(Current date:C33; "yyyymmdd")+")"
	$at_buildNo{1}:=JSON Stringify:C1217($vo_buildNoObj)
	ARRAY TO LIST:C287($at_buildNo; "BuildNo")
End if 

$0:=$vo_buildNoObj