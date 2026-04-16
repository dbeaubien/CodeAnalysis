//%attributes = {"invisible":true}
// CHART_Line_AddNumberedValues (ChartID; ValuesArray; DatesArray; lineColour)
// 
// DESCRIPTION
//   Draws a graph line along the specified equally
//   spaced number based data points.
//
//   Pass in two arrays, 1st is the data point, and 2nd
//   is the number that the data point occured on.
//
#DECLARE($chartID : Text\
; $vp_ar_valuesArrayPtr : Pointer\
; $vp_al_valuesArrayPtr : Pointer\
; $vt_lineColour : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 4; Count parameters:C259))
	SORT ARRAY:C229($vp_al_valuesArrayPtr->; $vp_ar_valuesArrayPtr->; >)  // store it sorted
	
	// Figure out which "line" we are about to add
	var $vl_lineNo : Integer
	$vl_lineNo:=OT_GetLong($chartID; "dataLines Count")+1
	OT_PutLong($chartID; "dataLines Count"; $vl_lineNo)
	
	// Store the attributes for the line into the object
	OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".type"; "numberedValues")
	OT_PutArray($chartID; "dataLine "+String:C10($vl_lineNo)+".xAxis_numbers"; $vp_al_valuesArrayPtr)
	OT_PutArray($chartID; "dataLine "+String:C10($vl_lineNo)+".yAxis_values"; $vp_ar_valuesArrayPtr)
	OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".lineColour"; $vt_lineColour)
	OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".indicator"; "none")
	
	CHART_Line_SetSeriesLabel($chartID; "Series "+String:C10($vl_lineNo))
End if 