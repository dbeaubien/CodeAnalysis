C_LONGINT:C283($vl_tableNo)
C_TEXT:C284($vt_formName; $vt_diskFilePath)
$vl_tableNo:=Table:C252(->[Table_1:1])
$vt_formName:="Input"
$vt_diskFilePath:="test.json"
FormProperties_SaveToFile($vl_tableNo; $vt_formName; $vt_diskFilePath)
