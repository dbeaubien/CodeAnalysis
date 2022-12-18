//%attributes = {"invisible":true}
// CHART_Area_SetSeriesLabel (ChartID; Series Name)
// CHART_Area_SetSeriesLabel (longint; text)
// 
// DESCRIPTION
//   Sets the name of the most recently added line series.
//
C_TEXT:C284($1; $chartID)
C_TEXT:C284($2; $vt_seriesName)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (08/08/12)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$chartID:=$1
	$vt_seriesName:=$2
	
	CHART_Line_SetSeriesLabel($chartID; $vt_seriesName)
End if   // ASSERT
