//%attributes = {"invisible":true,"preemptive":"capable"}
// XML_AddAttributesToObject (ref, object_to_update) 
//
#DECLARE($ref : Text; $object_to_update : Object)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

var $i : Integer
var $attribute_name; $attribute_value : Text
For ($i; 1; DOM Count XML attributes:C727($ref))
	DOM GET XML ATTRIBUTE BY INDEX:C729($ref; $i; $attribute_name; $attribute_value)
	$object_to_update[$attribute_name]:=$attribute_value
End for 

