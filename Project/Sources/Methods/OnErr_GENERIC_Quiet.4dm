//%attributes = {"invisible":true}
// Method: OnErr_GENERIC_Quiet
//   The simplest error handler

OnErr_SupressError

var gErrorMessage : Text
var gError : Integer
gError:=Error
gErrorMessage:=""  // Clear this

var $error : Object
For each ($error; Last errors:C1799)
	gErrorMessag+="\r [Error #"+String:C10($error.errCode)+"] "+$error.message
End for each 

LogEvent_Write("\r"\
+Str_DateTimeStamp\
+"\t ** RUNTIME ERROR occured in method "+Error method+" line #"+String:C10(Error line)+" **:"+gErrorMessage)
