//%attributes = {"invisible":true}
// CHART_Line_SetPointIndicator (ChartID; Shape; Width; Colour)
// CHART_Line_SetPointIndicator (longint; text; longint; text)
// 
// DESCRIPTION
//   Sets the most recent line to have the specified
//   indicator.
//
C_TEXT:C284($1; $chartID)
C_TEXT:C284($2; $vt_indicatorShape)
C_LONGINT:C283($3; $vl_width)
C_TEXT:C284($4; $vt_lineColour)
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
	$vt_indicatorShape:=$2
	$vl_width:=$3
	$vt_lineColour:=$4
	
	C_LONGINT:C283($vl_lineNo)
	$vl_lineNo:=OT_GetLong($chartID; "dataLines Count")
	
	If ($vl_lineNo>0)
		OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".indicator"; $vt_indicatorShape)
		OT_PutLong($chartID; "dataLine "+String:C10($vl_lineNo)+".indicatorWidth"; $vl_width)
		OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".indicatorColour"; $vt_lineColour)
	End if 
	
End if   // ASSERT
