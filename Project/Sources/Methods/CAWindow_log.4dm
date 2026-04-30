//%attributes = {"invisible":true}
// CAWindow_log (message)
//
// DESCRIPTION
//   Adds the message to the interprocess text var
//   that is shown on the "Exporting" tab of the Code Aalysis Window.
//
#DECLARE($message : Text)
// ----------------------------------------------------

var <>vt_ExportToResults : Text

If ($message#"")
	<>vt_ExportToResults+=$message
End if 