//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: NUM_GetMinReal
// 
// DESCRIPTION
//   Returns the smaller of the two reals
//
// PARAMETERS:
C_REAL:C285($1)
C_REAL:C285($2)
//
// RETURNS:
C_REAL:C285($0)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (10/22/09)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	
	If ($1<$2)
		$0:=$1
	Else 
		$0:=$2
	End if 
	
End if   // ASSERT
