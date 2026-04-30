var $vl_tab : Integer
$vl_tab:=SubTabControl
If ($vl_tab>1)
	$vl_tab:=$vl_tab-1
	Generator__SetPage(TabControl; $vl_tab)
End if 