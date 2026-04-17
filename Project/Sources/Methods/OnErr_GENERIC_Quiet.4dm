//%attributes = {"invisible":true}
// Method: OnErr_GENERIC_Quiet
//   The simplest error handler

OnErr_SupressError

var gErrorMessage : Text
var gError : Integer
gError:=Error
gErrorMessage:=""  // Clear this

ARRAY LONGINT:C221($al_err_code; 0)
ARRAY TEXT:C222($as_component; 0)
ARRAY TEXT:C222($as_error; 0)
_O_GET LAST ERROR STACK:C1015($al_err_code; $as_component; $as_error)
var $i : Integer
For ($i; 1; Size of array:C274($al_err_code))
	gErrorMessage:=gErrorMessage+"\r [Error #"+String:C10($al_err_code{$i})+"] "+$as_error{$i}
End for 

LogEvent_Write("\r"+Str_DateTimeStamp+"\t ** RUNTIME ERROR occured in method "+Error method+" line #"+String:C10(Error line)+" **:"+gErrorMessage)
