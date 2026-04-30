//%attributes = {"invisible":true}
// CHART_Config_SetHorzDateFormat ( chartID; dateFormat )
// 
// DESCRIPTION
//   Sets the format that the dates labels will appear on
//   the horizonatal axis.
//
#DECLARE($chartID : Text; $vt_dateFormat : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	OT_PutText($chartID; "horzDateLabelFormat"; $vt_dateFormat)
End if 