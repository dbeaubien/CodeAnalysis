//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: CHART_SVG_GetGridRef
// 
// DESCRIPTION
//   Returns the SVG Reference for the added grid.
//
// PARAMETERS:
C_TEXT:C284($1; $chartID)
//   
// RETURNS:
C_TEXT:C284($0; $vt_gridRef)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/23/11)
// ----------------------------------------------------

$vt_gridRef:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$chartID:=$1
	
	$vt_gridRef:=OT_GetText($chartID; "SVG gridRef")
	If ($vt_gridRef="")
		$vt_gridRef:=CHART_SVG_GetMasterRef($chartID)
	End if 
	
End if   // ASSERT
$0:=$vt_gridRef