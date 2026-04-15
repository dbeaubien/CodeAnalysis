//%attributes = {"invisible":true}
// CHART_Line_SetSeriesLabel (ChartID; Series Name)
// 
// DESCRIPTION
//   Sets the name of the most recently added line series.
//
#DECLARE($chartID : Text; $seriesName : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	
	var $vl_lineNo : Integer
	$vl_lineNo:=OT_GetLong($chartID; "dataLines Count")
	
	If ($vl_lineNo>0)
		OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".seriesLabel"; $seriesName)
	End if 
	
End if 
