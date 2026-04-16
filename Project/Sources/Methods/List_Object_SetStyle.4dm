//%attributes = {"invisible":true}
// List_Object_SetStyle (objectName; style; alignment)
// 
// DESCRIPTION
//   Sets the font style and alignment of the named object. 
//
#DECLARE($vt_objName : Text; $vl_style : Integer; $vl_alignment : Integer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	OBJECT SET FONT STYLE:C166(*; $vt_objName; $vl_style)
	OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vt_objName; $vl_alignment)
End if 

