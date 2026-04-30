//%attributes = {"invisible":true}
// OT_New () : ObjID
// 
// DESCRIPTION
//   Create a new OT mock object.
//
#DECLARE() : Text
// ----------------------------------------------------

var $xml_Ref : Text
$xml_Ref:=DOM Create XML Ref:C861("OT_MockObject")
If (OK=1)
	return $xml_Ref
Else 
	return ""
End if 
