//%attributes = {"invisible":true}
// Method: DEV_ASSERT_PARMCOUNT (method name; number of expected parameters;
//    actual number of parameters) :  isOKay

// This method is used for debugging purposes. It is used to test assumptions.
//  if $1 is false, then there is an error and the error string is presented

C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_LONGINT:C283($2; $3)

$0:=DEV_ASSERT($2=$3; $1+" is expecting "+String:C10($2)+" parameters but only got "+String:C10($3)+".")
