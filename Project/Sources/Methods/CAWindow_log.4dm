//%attributes = {"invisible":true}
// CAWindow_log (message)
// CAWindow_log (text)
//
// DESCRIPTION
//   Adds the message to the interprocess text var
//   that is shown on the "Exporting" tab of the Code Aalysis Window.
//
C_TEXT:C284($1)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (07/15/2017)
// ----------------------------------------------------

C_TEXT:C284(<>vt_ExportToResults)
If ($1#"")
	<>vt_ExportToResults:=<>vt_ExportToResults+$1
End if 