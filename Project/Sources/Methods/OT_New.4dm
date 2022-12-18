//%attributes = {"invisible":true}
// OT_New () : ObjID
// OT_New () : text
// 
// DESCRIPTION
//   Create a new OT mock object.
//
C_TEXT:C284($0; $xml_Ref)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/11/2014)
// ----------------------------------------------------

$xml_Ref:=DOM Create XML Ref:C861("OT_MockObject")
If (OK=1)
	$0:=$xml_Ref
Else 
	$0:=""
End if 
