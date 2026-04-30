//%attributes = {"invisible":true}
// Boolean2String
// 
// DESCRIPTION
//   Turns a boolean into a nice string
//
#DECLARE($boolean : Boolean; $yes_value : Text; $no_value : Text) : Text
//   $1: boolean
//   $2: yes value
//   $3: no value
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	
	If ($boolean)
		return $yes_value
	Else 
		return $no_value
	End if 
	
End if 
