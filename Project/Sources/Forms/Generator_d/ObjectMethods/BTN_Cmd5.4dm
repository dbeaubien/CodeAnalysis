var $vl_tab : Integer
$vl_tab:=SubTabControl
If ($vl_tab<Size of array:C274(SubTabControl))
	$vl_tab:=$vl_tab+1
	Generator__SetPage(TabControl; $vl_tab)
End if 