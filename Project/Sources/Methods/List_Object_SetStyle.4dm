//%attributes = {"invisible":true}
// List_Object_SetStyle (objectName; style; alignment)
// List_Object_SetStyle (text; longint; longint)
// 
// DESCRIPTION
//   Sets the font style and alignment of the named object. 
//
C_TEXT:C284($1; $vt_objName)
C_LONGINT:C283($2; $vl_style)
C_LONGINT:C283($3; $vl_alignment)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (12/13/2016)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$vt_objName:=$1
	$vl_style:=$2
	$vl_alignment:=$3
	
	OBJECT SET FONT STYLE:C166(*; $vt_objName; $vl_style)
	OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vt_objName; $vl_alignment)
End if   // ASSERT

