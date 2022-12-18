//%attributes = {"invisible":true}
// OT_Clear (ObjID)
// OT_Clear (text)
// 
// DESCRIPTION
//   Clear the mock object
//
C_TEXT:C284($1)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/11/2014)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	DOM CLOSE XML:C722($1)
End if   // ASSERT