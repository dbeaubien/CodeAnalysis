//%attributes = {"preemptive":"capable"}
//Progress QUIT (0)

$ms:=Milliseconds:C459
C_TEXT:C284($vt_xml)
EXPORT STRUCTURE:C1311($vt_xml)

C_OBJECT:C1216($vo_structure)
$vo_structure:=UTL_structure2Object($vt_xml)
ALERT:C41(String:C10(Milliseconds:C459-$ms))

SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($vo_structure; *))
BEEP:C151
ABORT:C156


//_DIFF_ChangesText 

var $timings : Collection
$timings:=New collection:C1472()

var $vs; $ve : Integer
var $model : cs:C1710.model_TableInformation
$model:=cs:C1710.model_TableInformation.new()

$vs:=Milliseconds:C459
$model._init()
$ve:=Milliseconds:C459
$timings.push("This._init() ->"+String:C10($ve-$vs)+"ms")

$vs:=Milliseconds:C459
$model._load_catalog_info()
$ve:=Milliseconds:C459
$timings.push("This._load_catalog_info() ->"+String:C10($ve-$vs)+"ms")

$vs:=Milliseconds:C459
$model._load_table_model()
$ve:=Milliseconds:C459
$timings.push("This._load_table_model() ->"+String:C10($ve-$vs)+"ms")

$vs:=Milliseconds:C459
$model._load_field_model()
$ve:=Milliseconds:C459
$timings.push("This._load_field_model() ->"+String:C10($ve-$vs)+"ms")

$vs:=Milliseconds:C459
$model.Refresh()
$ve:=Milliseconds:C459
$timings.push("This.Refresh() ->"+String:C10($ve-$vs)+"ms")

ALERT:C41($timings.join("\r"))