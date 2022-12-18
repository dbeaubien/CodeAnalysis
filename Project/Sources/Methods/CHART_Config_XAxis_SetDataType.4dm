//%attributes = {"invisible":true}
// CHART_Config_XAxis_SetDataType (chartID; axisDataType)
// CHART_Config_XAxis_SetDataType (text; longint)
// 
// DESCRIPTION
//   
//
C_TEXT:C284($1; $chartID)
C_LONGINT:C283($2; $vl_axisDataType)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/13/2014)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$chartID:=$1
	$vl_axisDataType:=$2
	
	OT_PutLong($chartID; "horzAxisDataType"; $vl_axisDataType)
End if   // ASSERT