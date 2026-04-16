//%attributes = {"invisible":true}
// NUM_GetMinLongint
// 
// DESCRIPTION
//   Returns the smaller of the two Longints
//
#DECLARE($num1 : Integer; $num2 : Integer) : Integer
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

If ($num1<$num2)
	return $num1
End if 

return $num2