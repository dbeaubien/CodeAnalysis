//%attributes = {"invisible":true,"preemptive":"incapable"}
// BuildNo_SetBuildNo (year; releaseNo; buildNo)
// BuildNo_SetBuildNo (text; text; text)
// 
// DESCRIPTION
//   Stores the build no object for the component.
//   For example: {"releaseYear":"2017","releaseNo":"r1","buildNo":"20170529","versionShort":"2017.r1","versionLong":"2017.r1 (build 20170529)"}
//   
//   NOTE: Cannot be run in a pre-emptive process.
//   NOTE: Private to the component
//
C_TEXT:C284($1; $vt_stringYear)
C_TEXT:C284($2; $vt_stringReleaseNo)
C_TEXT:C284($3; $vt_stringBuildNo)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (05/29/2017)
// ----------------------------------------------------

ASSERT:C1129(Count parameters:C259=3)
$vt_stringYear:=$1
$vt_stringReleaseNo:=$2
$vt_stringBuildNo:=$3

// Construct the bulid No obj
C_OBJECT:C1216($vo_buildNoObj)
$vo_buildNoObj:=New object:C1471
OB SET:C1220($vo_buildNoObj; "releaseYear"; $vt_stringYear)
OB SET:C1220($vo_buildNoObj; "releaseNo"; $vt_stringReleaseNo)
OB SET:C1220($vo_buildNoObj; "buildNo"; $vt_stringBuildNo)
OB SET:C1220($vo_buildNoObj; "versionShort"; $vt_stringYear+"."+$vt_stringReleaseNo)
OB SET:C1220($vo_buildNoObj; "versionLong"; $vt_stringYear+"."+$vt_stringReleaseNo+" (build "+$vt_stringBuildNo+")")

ARRAY TEXT:C222($at_buildNo; 1)
$at_buildNo{1}:=JSON Stringify:C1217($vo_buildNoObj)
//SET TEXT TO PASTEBOARD($at_buildNo{1})

// Save it into the structure
ARRAY TO LIST:C287($at_buildNo; "BuildNo")
