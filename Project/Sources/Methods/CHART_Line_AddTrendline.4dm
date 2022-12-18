//%attributes = {"invisible":true}
// CHART_Line_AddTrendline (ChartID; startValue; endValue; lineColour)
// CHART_Line_AddTrendline (longint; longint; longint; text)
// 
// DESCRIPTION
//   Draws a trend line that starts at the specified point
//   and ends at the specified point.
//
C_TEXT:C284($1; $chartID)
C_LONGINT:C283($2; $vl_startValue)
C_LONGINT:C283($3; $vl_endValue)
C_TEXT:C284($4; $vt_lineColour)
//
// RETURNS:
//   none
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (06/07/11)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 4; Count parameters:C259))
	$chartID:=$1
	$vl_startValue:=$2
	$vl_endValue:=$3
	$vt_lineColour:=$4
	
	// Figure out which "line" we are about to add
	C_LONGINT:C283($vl_lineNo)
	$vl_lineNo:=OT_GetLong($chartID; "dataLines Count")+1
	OT_PutLong($chartID; "dataLines Count"; $vl_lineNo)
	
	// Store the attributes for the line into the object
	OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".type"; "trendline")
	OT_PutLong($chartID; "dataLine "+String:C10($vl_lineNo)+".startValue"; $vl_startValue)
	OT_PutLong($chartID; "dataLine "+String:C10($vl_lineNo)+".endValue"; $vl_endValue)
	OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".lineColour"; $vt_lineColour)
	OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".indicator"; "none")
	
	CHART_Line_SetSeriesLabel($chartID; "Series "+String:C10($vl_lineNo))
End if   // ASSERT