//%attributes = {"invisible":true}
// CHART_Config_XAxis_SetDataType (chartID; axisDataType)
//
#DECLARE($chartID : Text; $vl_axisDataType : Integer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	OT_PutLong($chartID; "horzAxisDataType"; $vl_axisDataType)
End if 