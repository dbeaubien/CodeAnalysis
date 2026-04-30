var $vp_stringBuildNo : Pointer
$vp_stringBuildNo:=OBJECT Get data source:C1265(*; "string_buildNo")

$vp_stringBuildNo->:=Date2String(Current date:C33; "yyyymmdd")
