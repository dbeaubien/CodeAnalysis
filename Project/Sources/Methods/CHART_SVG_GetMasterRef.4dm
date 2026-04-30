//%attributes = {"invisible":true}
// CHART_SVG_GetMasterRef
// 
// DESCRIPTION
//   Returns the SVG Reference.
//
#DECLARE($chartID : Text) : Text
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	return OT_GetText($chartID; "SVG masterRef")
End if 
