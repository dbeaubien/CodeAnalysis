//%attributes = {"invisible":true}
// Method: OnErr_GENERIC
//   The simplest error handler

OnErr_ClearError
OnErr_GENERIC_Quiet

//   Mod: DB (10/08/2014) - Improve error reporting
C_TEXT:C284(<>vt_ExportToResults; $vt_alertText)
$vt_alertText:="\r#### RUNTIME ERROR(S) occured in method "+Error method+" line #"+String:C10(Error line)+":\r"
$vt_alertText:=$vt_alertText+gErrorMessage+"\r"
<>vt_ExportToResults:=<>vt_ExportToResults+$vt_alertText

LogEvent_Write($vt_alertText)