//%attributes = {"invisible":true}
// Component_GraphingDialog
// Component_GraphingDialog
//
// DESCRIPTION
//   Shows the Release Notes Dialog.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/05/2012)
// ----------------------------------------------------


If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
	C_POINTER:C301($NIL_p)
	
	WIN_Dialog($NIL_p; "AnalysisGraph_d"; Round corner window:K34:8; "Code Analysis Graphs - Method Counts"; On the left:K39:2; At the top:K39:5)
End if 