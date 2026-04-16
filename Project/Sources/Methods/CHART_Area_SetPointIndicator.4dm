//%attributes = {"invisible":true}
// CHART_Area_SetPointIndicator (ChartID; Shape; Width; Colour)
// 
// DESCRIPTION
//   Sets the most recent Area to have the specified
//   indicator.
//
#DECLARE($chartID : Text\
; $vt_indicatorShape : Text\
; $vl_width : Integer\
; $vt_AreaColour : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 4; Count parameters:C259))
	CHART_Line_SetPointIndicator($chartID; $vt_indicatorShape; $vl_width; $vt_AreaColour)
End if 
