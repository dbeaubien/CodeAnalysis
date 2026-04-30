//%attributes = {"invisible":true}
// CHART_Config_YAxis_SetIncrement (chartID; axisIncrement)
// 
// DESCRIPTION
//   Set the increment to be used for the y axis labels.
//
#DECLARE($chartID : Text; $axisIncrement : Real)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	OT_PutReal($chartID; "verticalAxisIncrement"; $axisIncrement)
End if 