//%attributes = {"invisible":true}
// CHART_Line_AddTrendline (ChartID; startValue; endValue; lineColour)
// 
// DESCRIPTION
//   Draws a trend line that starts at the specified point
//   and ends at the specified point.
//
#DECLARE($chartID : Text\
; $vl_startValue : Integer\
; $vl_endValue : Integer\
; $vt_lineColour : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 4; Count parameters:C259))
	// Figure out which "line" we are about to add
	var $vl_lineNo : Integer
	$vl_lineNo:=OT_GetLong($chartID; "dataLines Count")+1
	OT_PutLong($chartID; "dataLines Count"; $vl_lineNo)
	
	// Store the attributes for the line into the object
	OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".type"; "trendline")
	OT_PutLong($chartID; "dataLine "+String:C10($vl_lineNo)+".startValue"; $vl_startValue)
	OT_PutLong($chartID; "dataLine "+String:C10($vl_lineNo)+".endValue"; $vl_endValue)
	OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".lineColour"; $vt_lineColour)
	OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".indicator"; "none")
	
	CHART_Line_SetSeriesLabel($chartID; "Series "+String:C10($vl_lineNo))
End if 