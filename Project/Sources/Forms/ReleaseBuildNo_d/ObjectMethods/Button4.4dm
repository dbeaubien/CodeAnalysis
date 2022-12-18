C_POINTER:C301($vp_stringBuildNo)
$vp_stringBuildNo:=OBJECT Get data source:C1265(*; "string_buildNo")

$vp_stringBuildNo->:=Date2String(Current date:C33; "yyyymmdd")
