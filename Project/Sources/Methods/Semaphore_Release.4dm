//%attributes = {"invisible":true}
// ----------------------------------------------------
// METHOD: Semaphore_Release
// 
// DESCRIPTION
//   [FillThisIn]
// 
// ASSUMPTIONS:
//   none
// ----------------------------------------------------
// PARAMETERS:
C_TEXT:C284($1)
//
// RETURNS:
//   none
// ----------------------------------------------------
// CALLED BY:
//   [FillThisIn_IfAppropriate]
// ----------------------------------------------------
// HISTORY:
//   Created by DB on (2006.01.11 @ 14:43:26) -
// ----------------------------------------------------

// NOTE: The other side of "Semaphore_Grab" method

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	CLEAR SEMAPHORE:C144($1)
	
End if   // ASSERT
