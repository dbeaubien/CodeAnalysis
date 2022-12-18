//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: CHART_Clear
// 
// DESCRIPTION
//   Clears the chart
//
// PARAMETERS:
C_TEXT:C284($1; $chartID)
//   
// RETURNS:
//   none
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/23/11)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$chartID:=$1
	
	SVG_CLEAR(CHART_SVG_GetMasterRef($chartID))
	
	OT_Clear($chartID)
End if   // ASSERT
