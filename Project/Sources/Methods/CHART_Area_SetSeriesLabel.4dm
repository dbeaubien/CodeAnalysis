//%attributes = {"invisible":true}
// CHART_Area_SetSeriesLabel (ChartID; Series Name)
// 
// DESCRIPTION
//   Sets the name of the most recently added line series.
//
#DECLARE($chartID : Text; $seriesName : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	CHART_Line_SetSeriesLabel($chartID; $seriesName)
End if 
