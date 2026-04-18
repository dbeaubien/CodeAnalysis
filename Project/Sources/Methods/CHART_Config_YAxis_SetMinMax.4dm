//%attributes = {"invisible":true}
// CHART_Config_YAxis_SetMinMax (chartID; minHeight; maxHeight)
// 
// DESCRIPTION
//   Set the max for the vertical axis.
//
#DECLARE($chartID : Text\
; $vl_minVerticalHeight : Integer\
; $vl_maxVerticalHeight : Integer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	OT_PutLong($chartID; "minVerticalHeight_isSet"; 1)
	OT_PutLong($chartID; "minVerticalHeight"; $vl_minVerticalHeight)
	
	OT_PutLong($chartID; "maxVerticalHeight_isSet"; 1)
	OT_PutLong($chartID; "maxVerticalHeight"; $vl_maxVerticalHeight)
End if 