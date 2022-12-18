//%attributes = {"invisible":true}
// CHART_Config_ShowSeriesLabels (chartID; showSeries{; width})
// CHART_Config_ShowSeriesLabels (longint; boolean{; longint})
// 
// DESCRIPTION
//   If true, then the series labels will be displayed.
//
C_TEXT:C284($1; $chartID)
C_BOOLEAN:C305($2; $vb_showSeriesLabels)
C_LONGINT:C283($3; $vl_width)  // OPTIONAL, defaults to 100
// ----------------------------------------------------
// CALLED BY
//   CHART_CreateNewGraph
// ----------------------------------------------------
// HISTORY
//   Created by: DB (08/08/12)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 2; 3; Count parameters:C259))
	$chartID:=$1
	$vb_showSeriesLabels:=$2
	If (Count parameters:C259>=3)
		$vl_width:=$3
	Else 
		$vl_width:=100
	End if 
	
	If ($vb_showSeriesLabels)
		OT_PutText($chartID; "seriesLegend_ShowLabels"; "Yes")
	Else 
		OT_PutText($chartID; "seriesLegend_ShowLabels"; "No")
	End if 
	
	OT_PutLong($chartID; "seriesLegend_width"; $vl_width)
End if   // ASSERT
