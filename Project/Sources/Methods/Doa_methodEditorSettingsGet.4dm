//%attributes = {}
//Doa_methodEditorSettingsGet -> coll

// FROM DISCUSS FORUM: https://discuss.4d.com/t/formatted-method-code/14299/9

#DECLARE()->$settings_c : Collection
$settings_c:=[]

var $path_t; $xml_t : Text
$path_t:=Dev_4DprefsFilePath
If (Test path name:C476($path_t)#Is a document:K24:1)
	return $settings_c
End if 

$xml_t:=DOM Parse XML source:C719($path_t)
If (ok=1)
	var $RGB_t; $r; $g; $b : Text
	var $prefs_o; $syntax_o : Object
	$prefs_o:=Xml_ToObject($xml_t)
	DOM CLOSE XML:C722($xml_t)
	ASSERT:C1129($prefs_o.preferences.com__4d#Null:C1517)
	$r:=String:C10(Num:C11($prefs_o.preferences.com__4d.method_editor.back_color.color.red); "&x")
	$g:=String:C10(Num:C11($prefs_o.preferences.com__4d.method_editor.back_color.color.green); "&x")
	$b:=String:C10(Num:C11($prefs_o.preferences.com__4d.method_editor.back_color.color.blue); "&x")
	$RGB_t:="#"+$r[[5]]+$r[[6]]+$g[[5]]+$g[[6]]+$b[[5]]+$b[[6]]
	
	
	For each ($syntax_o; $prefs_o.preferences.com__4d.method_editor.syntax_style.syntax)
		$r:=String:C10(Num:C11($syntax_o.color.red); "&x")
		$g:=String:C10(Num:C11($syntax_o.color.green); "&x")
		$b:=String:C10(Num:C11($syntax_o.color.blue); "&x")
		$syntax_o.rgb:="#"+$r[[5]]+$r[[6]]+$g[[5]]+$g[[6]]+$b[[5]]+$b[[6]]
		$settings_c.push($syntax_o)
	End for each 
End if 
