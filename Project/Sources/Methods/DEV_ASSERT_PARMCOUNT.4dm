//%attributes = {"invisible":true}
// Method: DEV_ASSERT_PARMCOUNT (method name; number of expected parameters;
//    actual number of parameters) :  isOKay

// This method is used for debugging purposes. It is used to test assumptions.
//  if $method_name is false, then there is an error and the error string is presented

#DECLARE($method_name : Text\
; $num_params : Integer\
; $expected_num : Integer) : Boolean


return DEV_ASSERT($num_params=$expected_num; $method_name+" is expecting "+String:C10($num_params)+" parameters but only got "+String:C10($expected_num)+".")
