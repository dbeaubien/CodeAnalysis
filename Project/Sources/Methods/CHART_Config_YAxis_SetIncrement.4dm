//%attributes = {"invisible":true}
// CHART_Config_YAxis_SetIncrement (chartID; axisIncrement)
// CHART_Config_YAxis_SetIncrement (text; real)
// 
// DESCRIPTION
//   Set the increment to be used for the y axis labels.
//
C_TEXT:C284($1; $chartID)
C_REAL:C285($2; $axisIncrement)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/06/2013)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$chartID:=$1
	$axisIncrement:=$2
	
	OT_PutReal($chartID; "verticalAxisIncrement"; $axisIncrement)
End if   // ASSERT