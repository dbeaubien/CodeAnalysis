//%attributes = {"invisible":true}
// CHART_Line_SetSeriesLabel (ChartID; Series Name)
// CHART_Line_SetSeriesLabel (longint; text)
// 
// DESCRIPTION
//   Sets the name of the most recently added line series.
//
C_TEXT:C284($1; $chartID)
C_TEXT:C284($2; $vt_seriesName)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (08/08/12)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$chartID:=$1
	$vt_seriesName:=$2
	
	C_LONGINT:C283($vl_lineNo)
	$vl_lineNo:=OT_GetLong($chartID; "dataLines Count")
	
	If ($vl_lineNo>0)
		OT_PutText($chartID; "dataLine "+String:C10($vl_lineNo)+".seriesLabel"; $vt_seriesName)
	End if 
	
End if   // ASSERT
