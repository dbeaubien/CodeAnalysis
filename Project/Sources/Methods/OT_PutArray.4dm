//%attributes = {"invisible":true}
// OT_PutArray (objID; tag; ptrToArray)
// 
// DESCRIPTION
//   Put the array into the mock object under tag
//
#DECLARE($xml_Ref : Text; $vt_tag : Text; $arrayToPut_Ptr : Pointer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	
	ARRAY TEXT:C222($at_values; Size of array:C274($arrayToPut_Ptr->))
	Case of 
		: (Size of array:C274($at_values)=0)
			// NOTHING TO CONVERT
			
		: (Type:C295($arrayToPut_Ptr->)=Text array:K8:16)
			COPY ARRAY:C226($arrayToPut_Ptr->; $at_values)
			
		: (Type:C295($arrayToPut_Ptr->)=Date array:K8:20)
			var $i : Integer
			For ($i; 1; Size of array:C274($arrayToPut_Ptr->))
				$at_values{$i}:=String:C10($arrayToPut_Ptr->{$i})
			End for 
			
		: (Type:C295($arrayToPut_Ptr->)=Real array:K8:17) | (Type:C295($arrayToPut_Ptr->)=LongInt array:K8:19)
			For ($i; 1; Size of array:C274($arrayToPut_Ptr->))
				$at_values{$i}:=String:C10($arrayToPut_Ptr->{$i})
			End for 
			
		Else 
			TRACE:C157
			ALERT:C41("The array type is not supported")
			
	End case 
	
	var $vt_valueToPut : Text
	$vt_valueToPut:=Array_ConvertToTextDelimited(->$at_values; Char:C90(Tab:K15:37))
	$vt_valueToPut:=STR_Base64_Encode($vt_valueToPut)
	
	OT_PutText($xml_Ref; $vt_tag; $vt_valueToPut)
End if 