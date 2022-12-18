//%attributes = {"invisible":true}
// CHART_CreateNewGraph (width; height; title) -> chartID
// CHART_CreateNewGraph (longint; longint; text) -> text
// 
// DESCRIPTION
//   Create a new chart object and returns a chart ID.
//
C_LONGINT:C283($1; $vl_graphWidth)
C_LONGINT:C283($2; $vl_graphHeight)
C_TEXT:C284($3; $vt_title)
//   
// RETURNS:
C_TEXT:C284($0; $chartID)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/23/11)
// ----------------------------------------------------

$chartID:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$vl_graphWidth:=$1
	$vl_graphHeight:=$2
	$vt_title:=$3
	
	// enforce some mins
	If ($vl_graphWidth<200)
		$vl_graphWidth:=200
	End if 
	If ($vl_graphHeight<100)
		$vl_graphHeight:=100
	End if 
	
	$chartID:=OT_New
	OT_PutText($chartID; "title"; $vt_title)
	
	OT_PutText($chartID; "type"; "chart")
	OT_PutLong($chartID; "graphWidth"; $vl_graphWidth)
	OT_PutLong($chartID; "graphHeight"; $vl_graphHeight)
	
	C_LONGINT:C283($vl_gridWidth; $vl_gridHeight)
	$vl_gridWidth:=$vl_graphWidth-100  // give room for labels on Y axis
	$vl_gridHeight:=$vl_graphHeight
	
	OT_PutLong($chartID; "gridWidth"; $vl_gridWidth)
	OT_PutLong($chartID; "gridHeight"; $vl_gridHeight)
	
	C_TEXT:C284($vt_masterRef)
	$vt_masterRef:=SVG_New
	OT_PutText($chartID; "SVG masterRef"; $vt_masterRef)
	
	//C_LONGINT($vl_gridBoxSize)
	//$vl_gridBoxSize:=Int($vl_graphHeight/10)
	//CHART__Draw_GridBox ($chartID;$vl_graphHeight;$vt_title)
	
	CHART_Config_SetHorzDateFormat($chartID; "mm/dd/yyyy")
	CHART_Config_ShowSeriesLabels($chartID; False:C215)
	
End if   // ASSERT
$0:=$chartID