//%attributes = {"invisible":true}
// Method: DEV_ASSERT (boolean condition; error string) : boolean condition

// This method is used for debugging purposes. It is used to test assumptions.
//  if $1 is false, then there is an error and the error string is presented


C_BOOLEAN:C305($1)
C_TEXT:C284($2; $msg)
C_BOOLEAN:C305($0)  // returns $1

If ($1=False:C215)  // & (◊DEBUG)
	//If (Application type#4D Server)
	//$msg:="ASSERT ERROR:"+(Char(Carriage return)*2)+$2+(Char(Carriage return)*2)+"Please notify InfoHandler's Technical Support of this error."
	//If (Not(Is compiled mode(*)))
	//ALERT($msg)
	//End if 
	//EXECUTE METHOD("Logging_AddToLog";*;$msg)
	//End if 
	
	If (Not:C34(Is compiled mode:C492))
		TRACE:C157
	End if 
End if 

$0:=$1
