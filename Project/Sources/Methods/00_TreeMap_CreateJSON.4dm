//%attributes = {}

C_OBJECT:C1216(MethodStatsMasterObj)  // defined by MethodStats__Init
ARRAY TEXT:C222($methodObjNames; 0)
MethodStats__Init
Method_GetMethodObjNames(->$methodObjNames)

C_LONGINT:C283($i; $j)
C_OBJECT:C1216($vo_treeMap)
$vo_treeMap:=New object:C1471

C_OBJECT:C1216($methodDetails)
ARRAY TEXT:C222($parentModuleNamesArr; 0)
For ($j; 1; Size of array:C274($methodObjNames))
	$methodDetails:=MethodStatsMasterObj[$methodObjNames{$j}]
	If (Find in array:C230($parentModuleNamesArr; $methodDetails.in_module)<1)
		APPEND TO ARRAY:C911($parentModuleNamesArr; $methodDetails.in_module)
	End if 
End for 
SORT ARRAY:C229($parentModuleNamesArr; >)

ARRAY OBJECT:C1221($ao_modules; 0)
C_TEXT:C284($vt_curModule)
For ($j; 1; Size of array:C274($parentModuleNamesArr))
	$vt_curModule:=$parentModuleNamesArr{$j}
	If ($vt_curModule="")
		$vt_curModule:=" "
	End if 
	
	C_OBJECT:C1216($vo_aModule)
	$vo_aModule:=New object:C1471
	
	ARRAY OBJECT:C1221($ao_children; 0)
	C_OBJECT:C1216($vo_method)
	For ($i; 1; Size of array:C274($methodObjNames))
		$methodDetails:=MethodStatsMasterObj[$methodObjNames{$i}]
		If ($parentModuleNamesArr{$j}=$methodDetails.in_module)
			$vo_method:=New object:C1471
			$vo_method.name:=$methodDetails.viewing_name
			$vo_method.size:=$methodDetails.line_counts.lines
			APPEND TO ARRAY:C911($ao_children; $vo_method)
		End if 
	End for 
	OB SET:C1220($vo_aModule; "name"; $vt_curModule)
	OB SET ARRAY:C1227($vo_aModule; "children"; $ao_children)
	APPEND TO ARRAY:C911($ao_modules; $vo_aModule)
End for 


OB SET:C1220($vo_treeMap; "name"; File_GetFileName(Structure file:C489))
OB SET ARRAY:C1227($vo_treeMap; "children"; $ao_modules)

C_TEXT:C284($vt_folder; $vt_file)
$vt_folder:=Get 4D folder:C485(Current resources folder:K5:16)+"Graphs"+Folder separator:K24:12+"treemap"+Folder separator:K24:12
$vt_file:=$vt_folder+"treemap.json"
File_Delete($vt_file)

TEXT TO DOCUMENT:C1237($vt_file; JSON Stringify:C1217($vo_treeMap; *))
