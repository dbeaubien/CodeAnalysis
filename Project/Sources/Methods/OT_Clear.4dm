//%attributes = {"invisible":true}
// OT_Clear (ObjID)
// 
// DESCRIPTION
//   Clear the mock object
//
#DECLARE($xml_Ref : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	DOM CLOSE XML:C722($xml_Ref)
End if 