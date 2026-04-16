//%attributes = {"invisible":true}
// Component_DocDialog (tabToShow)
//
// DESCRIPTION
//   Shows the Release Notes Dialog.
//
#DECLARE($default_tab_no : Integer)
// ----------------------------------------------------

var <>_CODEANALYSIS_DOC_DEFAULTTABNO : Integer
If (Count parameters:C259>=1)
	<>_CODEANALYSIS_DOC_DEFAULTTABNO:=$default_tab_no
End if 

If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
	var $NIL_p : Pointer
	WIN_Dialog($NIL_p; "Documentation_d"; Plain window:K34:13; "Code Analysis Release Notes"; On the left:K39:2; At the top:K39:5)
End if 

