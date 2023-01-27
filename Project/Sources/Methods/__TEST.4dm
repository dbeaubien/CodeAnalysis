//%attributes = {"preemptive":"capable"}
//Progress QUIT (0)

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