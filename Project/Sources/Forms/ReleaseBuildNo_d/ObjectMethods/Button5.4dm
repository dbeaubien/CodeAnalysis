
var $vp_stringReleaseNo : Pointer
$vp_stringReleaseNo:=OBJECT Get data source:C1265(*; "string_releaseNo")

$vp_stringReleaseNo->:="r"+String:C10(Num:C11($vp_stringReleaseNo->)+1)
