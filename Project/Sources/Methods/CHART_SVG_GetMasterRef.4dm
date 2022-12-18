//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: CHART_SVG_GetMasterRef
// 
// DESCRIPTION
//   Returns the SVG Reference.
//
// PARAMETERS:
C_TEXT:C284($1; $chartID)
//   
// RETURNS:
C_TEXT:C284($0; $vt_masterRef)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/23/11)
// ----------------------------------------------------

$vt_masterRef:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$chartID:=$1
	
	$vt_masterRef:=OT_GetText($chartID; "SVG masterRef")
End if   // ASSERT
$0:=$vt_masterRef