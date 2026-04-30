//%attributes = {"invisible":true}
// OT_GetArray (objID; tag; ptrToArray) 
// 
// DESCRIPTION
//   Get the real number from the mock object under tag
//
#DECLARE($xml_Ref : Text; $vt_tag : Text; $arrayToGet_Ptr : Pointer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	
	var $vt_valueToGet : Text
	$vt_valueToGet:=OT_GetText($xml_Ref; $vt_tag)
	$vt_valueToGet:=STR_Base64_Decode($vt_valueToGet)
	
	ARRAY TEXT:C222($at_values; 0)
	Array_ConvertFromTextDelimited(->$at_values; $vt_valueToGet; Char:C90(Tab:K15:37))
	
	// Copy the array to our return value
	var $i : Integer
	Array_SetSize(Size of array:C274($at_values); $arrayToGet_Ptr)
	Case of 
		: (Size of array:C274($at_values)=0)
			// NOTHING TO CONVERT
			
		: (Type:C295($arrayToGet_Ptr->)=Text array:K8:16)
			COPY ARRAY:C226($at_values; $arrayToGet_Ptr->)
			
		: (Type:C295($arrayToGet_Ptr->)=Date array:K8:20)
			For ($i; 1; Size of array:C274($at_values))
				$arrayToGet_Ptr->{$i}:=Date:C102($at_values{$i})
			End for 
			
		: (Type:C295($arrayToGet_Ptr->)=Real array:K8:17) | (Type:C295($arrayToGet_Ptr->)=LongInt array:K8:19)
			For ($i; 1; Size of array:C274($at_values))
				$arrayToGet_Ptr->{$i}:=Num:C11($at_values{$i})
			End for 
			
		Else 
			TRACE:C157
			ALERT:C41("The array type is not supported")
			
	End case 
	
End if 