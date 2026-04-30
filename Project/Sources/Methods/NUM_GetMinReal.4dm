//%attributes = {"invisible":true}
// NUM_GetMinReal
// 
// DESCRIPTION
//   Returns the smaller of the two reals
//
#DECLARE($num1 : Real; $num2 : Real) : Real
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	
	If ($num1<$num2)
		return $num1
	Else 
		return $num2
	End if 
	
End if 
