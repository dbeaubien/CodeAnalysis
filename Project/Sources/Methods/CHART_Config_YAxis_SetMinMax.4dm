//%attributes = {"invisible":true}
// CHART_Config_YAxis_SetMinMax (chartID; minHeight; maxHeight)
// CHART_Config_YAxis_SetMinMax (longint; longint; longint)
// 
// DESCRIPTION
//   Set the max for the vertical axis.
//
C_TEXT:C284($1; $chartID)
C_LONGINT:C283($2; $vl_minVerticalHeight)
C_LONGINT:C283($3; $vl_maxVerticalHeight)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/06/2013)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$chartID:=$1
	$vl_minVerticalHeight:=$2
	$vl_maxVerticalHeight:=$3
	
	OT_PutLong($chartID; "minVerticalHeight_isSet"; 1)
	OT_PutLong($chartID; "minVerticalHeight"; $vl_minVerticalHeight)
	
	OT_PutLong($chartID; "maxVerticalHeight_isSet"; 1)
	OT_PutLong($chartID; "maxVerticalHeight"; $vl_maxVerticalHeight)
End if   // ASSERT