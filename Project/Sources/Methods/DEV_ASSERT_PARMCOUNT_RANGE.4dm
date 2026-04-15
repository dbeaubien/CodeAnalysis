//%attributes = {"invisible":true}
// Method: DEV_ASSERT_PARMCOUNT_RANGE (method name;
//    min expected parameters;
//    max expected parameters;
//    actual number of parameters) :  isOKay

// This method is used for debugging purposes. It is used to test assumptions.
//  if $method_name is false, then there is an error and the error string is presented

#DECLARE($method_name : Text\
; $min : Integer\
; $max : Integer\
; $numParms : Integer) : Boolean

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 4; Count parameters:C259))
	return DEV_ASSERT(($numParms>=$min) & ($numParms<=$max); $method_name+" is expecting "+String:C10($min)+" thru "+String:C10($max)+" parameters but only got "+String:C10($numParms)+".")
End if 
