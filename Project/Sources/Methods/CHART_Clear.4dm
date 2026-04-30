//%attributes = {"invisible":true}
// CHART_Clear
// 
// DESCRIPTION
//   Clears the chart
//
#DECLARE($chartID : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	SVG_CLEAR(CHART_SVG_GetMasterRef($chartID))
	
	OT_Clear($chartID)
End if 
