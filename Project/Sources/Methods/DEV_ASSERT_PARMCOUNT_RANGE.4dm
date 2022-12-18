//%attributes = {"invisible":true}
// Method: DEV_ASSERT_PARMCOUNT_RANGE (method name;
//    min expected parameters;
//    max expected parameters;
//    actual number of parameters) :  isOKay

// This method is used for debugging purposes. It is used to test assumptions.
//  if $1 is false, then there is an error and the error string is presented

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 4; Count parameters:C259))
	C_BOOLEAN:C305($0)
	C_TEXT:C284($1)
	C_LONGINT:C283($2; $3)
	C_LONGINT:C283($4; $numParms)
	$numParms:=$4
	
	$0:=DEV_ASSERT(($numParms>=$2) & ($numParms<=$3); $1+" is expecting "+String:C10($2)+" thru "+String:C10($3)+" parameters but only got "+String:C10($numParms)+".")
End if   // ASSERT_PARMCOUNT
