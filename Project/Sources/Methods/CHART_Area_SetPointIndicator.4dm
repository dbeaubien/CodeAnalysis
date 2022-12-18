//%attributes = {"invisible":true}
// CHART_Area_SetPointIndicator (ChartID; Shape; Width; Colour)
// CHART_Area_SetPointIndicator (longint; text; longint; text)
// 
// DESCRIPTION
//   Sets the most recent Area to have the specified
//   indicator.
//
C_TEXT:C284($1; $chartID)
C_TEXT:C284($2; $vt_indicatorShape)
C_LONGINT:C283($3; $vl_width)
C_TEXT:C284($4; $vt_AreaColour)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (08/08/2012)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 4; Count parameters:C259))
	$chartID:=$1
	$vt_indicatorShape:=$2
	$vl_width:=$3
	$vt_AreaColour:=$4
	
	CHART_Line_SetPointIndicator($chartID; $vt_indicatorShape; $vl_width; $vt_AreaColour)
End if   // ASSERT
