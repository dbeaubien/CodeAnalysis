//%attributes = {"invisible":true}
// CHART_SVG_GetGridRef ()
// 
// DESCRIPTION
//   Returns the SVG Reference for the added grid.
//
#DECLARE($chartID : Text)->$vt_gridRef : Text
// ----------------------------------------------------
$vt_gridRef:=""

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	$vt_gridRef:=OT_GetText($chartID; "SVG gridRef")
	If ($vt_gridRef="")
		$vt_gridRef:=CHART_SVG_GetMasterRef($chartID)
	End if 
	
End if 
