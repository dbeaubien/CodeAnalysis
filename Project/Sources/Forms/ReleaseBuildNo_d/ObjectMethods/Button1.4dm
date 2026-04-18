var $vo_buildNoObj : Object
$vo_buildNoObj:=BuildNo_GetBuildNo_CodeAnalysis

var $vp_stringYear : Pointer
$vp_stringYear:=OBJECT Get data source:C1265(*; "string_year")
$vp_stringYear->:=OB Get:C1224($vo_buildNoObj; "releaseYear"; Is text:K8:3)

var $vp_stringReleaseNo : Pointer
$vp_stringReleaseNo:=OBJECT Get data source:C1265(*; "string_releaseNo")
$vp_stringReleaseNo->:=OB Get:C1224($vo_buildNoObj; "releaseNo"; Is text:K8:3)

var $vp_stringBuildNo : Pointer
$vp_stringBuildNo:=OBJECT Get data source:C1265(*; "string_buildNo")
$vp_stringBuildNo->:=OB Get:C1224($vo_buildNoObj; "buildNo"; Is text:K8:3)