//%attributes = {"invisible":true}
// CHART_Area_AddDatedValues (ChartID; ValuesArray; DatesArray; AreaColour)
// 
// DESCRIPTION
//   Draws a graph Area along the specified equally
//   spaced date based data points.
//
//   Pass in two arrays, 1st is the data point, and 2nd
//   is the date that the data point occured on.
//
#DECLARE($chartID : Text\
; $vp_ar_valuesArrayPtr : Pointer\
; $vp_ad_valuesArrayPtr : Pointer\
; $vt_AreaColour : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 4; Count parameters:C259))
	SORT ARRAY:C229($vp_ad_valuesArrayPtr->; $vp_ar_valuesArrayPtr->; >)  // store it sorted
	
	// Figure out which "Area" we are about to add
	var $vl_AreaNo : Integer
	$vl_AreaNo:=OT_GetLong($chartID; "dataLines Count")+1
	OT_PutLong($chartID; "dataLines Count"; $vl_AreaNo)
	
	// Store the attributes for the Area into the object
	OT_PutText($chartID; "dataLine "+String:C10($vl_AreaNo)+".type"; "datedAreaLine")
	OT_PutArray($chartID; "dataLine "+String:C10($vl_AreaNo)+".xAxis_dates"; $vp_ad_valuesArrayPtr)
	OT_PutArray($chartID; "dataLine "+String:C10($vl_AreaNo)+".yAxis_values"; $vp_ar_valuesArrayPtr)
	OT_PutText($chartID; "dataLine "+String:C10($vl_AreaNo)+".lineColour"; $vt_AreaColour)
	OT_PutText($chartID; "dataLine "+String:C10($vl_AreaNo)+".indicator"; "none")
End if 