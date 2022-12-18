//%attributes = {"invisible":true}
// CHART_Config_SetHorzDateFormat ( chartID; dateFormat )
// CHART_Config_SetHorzDateFormat ( longint; text )
// 
// DESCRIPTION
//   Sets the format that the dates labels will appear on
//   the horizonatal axis.
//
C_TEXT:C284($1; $chartID)
C_TEXT:C284($2; $vt_dateFormat)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (06/29/11)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$chartID:=$1
	$vt_dateFormat:=$2
	
	OT_PutText($chartID; "horzDateLabelFormat"; $vt_dateFormat)
End if   // ASSERT