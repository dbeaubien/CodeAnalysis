
var $vp_stringYear : Pointer
$vp_stringYear:=OBJECT Get data source:C1265(*; "string_year")

$vp_stringYear->:=String:C10(Num:C11($vp_stringYear->)+1)