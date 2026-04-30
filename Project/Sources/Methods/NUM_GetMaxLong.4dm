//%attributes = {"invisible":true}
// NUM_GetMaxLongint
// 
// DESCRIPTION
//   Returns the larger of the two Longints
//
#DECLARE($num1 : Integer; $num2 : Integer) : Integer
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	If ($num1>$num2)
		return $num1
	Else 
		return $num2
	End if 
End if 
