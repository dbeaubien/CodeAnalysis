//%attributes = {"invisible":true}
// Component_DocDialog (tabToShow)
// Component_DocDialog (longint)
//
// DESCRIPTION
//   Shows the Release Notes Dialog.
//
C_LONGINT:C283($1; <>_CODEANALYSIS_DOC_DEFAULTTABNO)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/05/2012)
// ----------------------------------------------------

If (Count parameters:C259>=1)
	<>_CODEANALYSIS_DOC_DEFAULTTABNO:=$1
End if 

If (Process_LaunchAsNew(Current method name:C684; Current method name:C684))
	C_POINTER:C301($NIL_p)
	WIN_Dialog($NIL_p; "Documentation_d"; Plain window:K34:13; "Code Analysis Release Notes"; On the left:K39:2; At the top:K39:5)
End if 

