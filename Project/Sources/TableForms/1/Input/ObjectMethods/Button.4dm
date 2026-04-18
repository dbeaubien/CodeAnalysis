var $vl_tableNo : Integer
var $vt_formName; $vt_diskFilePath : Text
$vl_tableNo:=Table:C252(->[Table_1:1])
$vt_formName:="Input"
$vt_diskFilePath:="test.json"
FormProperties_SaveToFile($vl_tableNo; $vt_formName; $vt_diskFilePath)
