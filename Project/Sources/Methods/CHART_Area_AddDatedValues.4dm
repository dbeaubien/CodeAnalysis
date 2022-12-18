//%attributes = {"invisible":true}
// CHART_Area_AddDatedValues (ChartID; ValuesArray; DatesArray; AreaColour)
// CHART_Area_AddDatedValues (longint; Ptr To Real Array; Ptr to Date Array; text)
// 
// DESCRIPTION
//   Draws a graph Area along the specified equally
//   spaced date based data points.
//
//   Pass in two arrays, 1st is the data point, and 2nd
//   is the date that the data point occured on.
//
C_TEXT:C284($1; $chartID)
C_POINTER:C301($2; $vp_ar_valuesArrayPtr)
C_POINTER:C301($3; $vp_ad_valuesArrayPtr)
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
	$vp_ar_valuesArrayPtr:=$2
	$vp_ad_valuesArrayPtr:=$3
	$vt_AreaColour:=$4
	
	SORT ARRAY:C229($vp_ad_valuesArrayPtr->; $vp_ar_valuesArrayPtr->; >)  // store it sorted
	
	// Figure out which "Area" we are about to add
	C_LONGINT:C283($vl_AreaNo)
	$vl_AreaNo:=OT_GetLong($chartID; "dataLines Count")+1
	OT_PutLong($chartID; "dataLines Count"; $vl_AreaNo)
	
	// Store the attributes for the Area into the object
	OT_PutText($chartID; "dataLine "+String:C10($vl_AreaNo)+".type"; "datedAreaLine")
	OT_PutArray($chartID; "dataLine "+String:C10($vl_AreaNo)+".xAxis_dates"; $vp_ad_valuesArrayPtr)
	OT_PutArray($chartID; "dataLine "+String:C10($vl_AreaNo)+".yAxis_values"; $vp_ar_valuesArrayPtr)
	OT_PutText($chartID; "dataLine "+String:C10($vl_AreaNo)+".lineColour"; $vt_AreaColour)
	OT_PutText($chartID; "dataLine "+String:C10($vl_AreaNo)+".indicator"; "none")
End if   // ASSERT