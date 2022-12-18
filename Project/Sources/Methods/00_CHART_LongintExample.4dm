//%attributes = {"invisible":true}


If (True:C214)  // Generate random #s
	C_LONGINT:C283($vl_numIntervals)
	$vl_numIntervals:=40
	ARRAY TEXT:C222($at_labels; $vl_numIntervals)
	ARRAY LONGINT:C221($al_counts; $vl_numIntervals)
	ARRAY LONGINT:C221($al_xDataPoints; $vl_numIntervals)
	ARRAY REAL:C219($ar_dataPoints; $vl_numIntervals)
	ARRAY REAL:C219($ar_dataPoints2; $vl_numIntervals)
	
	$al_counts{1}:=100
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($at_labels))
		$al_xDataPoints{$i}:=$i
		
		$at_labels{$i}:="#"+String:C10($i)
		
		$al_counts{$i}:=$al_counts{$i-1}+Int:C8(Random:C100%(25+1))-12
		$ar_dataPoints{$i}:=$al_counts{$i}
		$ar_dataPoints2{$i}:=$ar_dataPoints2{$i-1}+Int:C8(Random:C100%(25+1))-12
		
		If ($al_counts{$i}<0) | ($al_counts{$i}>200)
			$i:=$i-1  // reduce this item
		End if 
	End for 
	
	$al_counts{1}:=0
End if 

C_LONGINT:C283($vl_graphWidth; $vl_graphHeight)
$vl_graphWidth:=600
$vl_graphHeight:=300

C_TEXT:C284($chartID)
$chartID:=CHART_CreateNewGraph($vl_graphWidth; $vl_graphHeight; "My first Test Graph")
CHART_Config_ShowSeriesLabels($chartID; True:C214)
CHART_Config_YAxis_SetMinMax($chartID; -100; 200)
CHART_Config_YAxis_SetIncrement($chartID; 25)
CHART_Config_XAxis_SetDataType($chartID; Is longint:K8:6)

// LINE #1
CHART_Area_AddNumberedValues($chartID; ->$ar_dataPoints; ->$al_xDataPoints; "lightblue")
CHART_Area_SetSeriesLabel($chartID; "Area Values")

If (Size of array:C274($al_xDataPoints)>40)
	DELETE FROM ARRAY:C228($al_xDataPoints; 20; 40)  // to show that there can be gaps in the dated values
	DELETE FROM ARRAY:C228($ar_dataPoints2; 20; 40)
End if 

CHART_Line_AddNumberedValues($chartID; ->$ar_dataPoints2; ->$al_xDataPoints; "green")
CHART_Line_SetPointIndicator($chartID; "triangle"; 6; "green")
CHART_Line_SetSeriesLabel($chartID; "Line Values")

//CHART_Config_SetHorzDateFormat ($chartID;"Mon dd")

CHART_Draw($chartID)

C_TEXT:C284($vt_filePath)
$vt_filePath:=Folder_ParentName(Get 4D folder:C485(Database folder:K5:14))+"Test longint image"
//CHART_SaveAsSVG ($chartID;$vt_filePath+".svg")
//CHART_SaveAsJPG ($chartID;$vt_filePath+".jpg")
CHART_SaveAsGIF($chartID; $vt_filePath+".gif")
CHART_SaveAsPNG($chartID; $vt_filePath+".png")
SHOW ON DISK:C922($vt_filePath+".png")

//C_PICTURE($v_graphPicture)
//$v_graphPicture:=SVG_Export_to_picture (CHART_SVG_GetMasterRef ($chartID))
//SET PICTURE TO PASTEBOARD($v_graphPicture)

CHART_Clear($chartID)

