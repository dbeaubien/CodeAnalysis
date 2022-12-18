//%attributes = {"invisible":true}
// CHART_Line_AddDatedValues (ChartID; ValuesArray; DatesArray; lineColour)
// CHART_Line_AddDatedValues (longint; Ptr To Real Array; Ptr to Date Array; text)
// 
// DESCRIPTION
//   Draws a graph line along the specified equally
//   spaced date based data points.
//
//   Pass in two arrays, 1st is the data point, and 2nd
//   is the date that the data point occured on.
//
C_TEXT:C284($1; $chartID)
C_POINTER:C301($2; $vp_ar_valuesArrayPtr)
C_POINTER:C301($3; $vp_ad_valuesArrayPtr)
C_TEXT:C284($4; $vt_lineColour)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/21/11)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 4; Count parameters:C259))
	$chartID:=$1
	$vp_ar_valuesArrayPtr:=$2
	$vp_ad_valuesArrayPtr:=$3
	$vt_lineColour:=$4
	
	SORT ARRAY:C229($vp_ad_valuesArrayPtr->; $vp_ar_valuesArrayPtr->; >)  // store it sorted
	
	// Figure out which "line" we are about to add
	C_LONGINT:C283($vl_lineNo)
	$vl_lineNo:=OT_GetLong($chartID; "dataLines Count")+1
	OT_PutLong($chartID; "dataLines Count"; $vl_lineNo)
	
	// Store the attributes for the line into the object
	OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".type"; "datedValues")
	OT_PutArray($chartID; "dataLine "+String:C10($vl_lineNo)+".xAxis_dates"; $vp_ad_valuesArrayPtr)
	OT_PutArray($chartID; "dataLine "+String:C10($vl_lineNo)+".yAxis_values"; $vp_ar_valuesArrayPtr)
	OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".lineColour"; $vt_lineColour)
	OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".indicator"; "none")
	
	CHART_Line_SetSeriesLabel($chartID; "Series "+String:C10($vl_lineNo))
End if   // ASSERT