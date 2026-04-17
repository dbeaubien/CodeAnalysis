//%attributes = {"invisible":true}
// Component_GraphingDialog
//
// DESCRIPTION
//   Shows the Release Notes Dialog.
//
// ----------------------------------------------------

If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
	var $NIL_p : Pointer
	
	WIN_Dialog($NIL_p; "AnalysisGraph_d"; Round corner window:K34:8; "Code Analysis Graphs - Method Counts"; On the left:K39:2; At the top:K39:5)
End if 