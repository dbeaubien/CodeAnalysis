//%attributes = {"invisible":true}
// CHART_Line_SetPointIndicator (ChartID; Shape; Width; Colour)
// 
// DESCRIPTION
//   Sets the most recent line to have the specified
//   indicator.
//
#DECLARE($chartID : Text\
; $vt_indicatorShape : Text\
; $vl_width : Integer\
; $vt_lineColour : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 4; Count parameters:C259))
	var $vl_lineNo : Integer
	$vl_lineNo:=OT_GetLong($chartID; "dataLines Count")
	
	If ($vl_lineNo>0)
		OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".indicator"; $vt_indicatorShape)
		OT_PutLong($chartID; "dataLine "+String:C10($vl_lineNo)+".indicatorWidth"; $vl_width)
		OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".indicatorColour"; $vt_lineColour)
	End if 
	
End if 
