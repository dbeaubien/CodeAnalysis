//%attributes = {"invisible":true}
// OT_GetArray (objID; tag; ptrToArray) 
// OT_GetArray (text; text; pointer)
// 
// DESCRIPTION
//   Get the real number from the mock object under tag
//
C_TEXT:C284($1; $xml_Ref)
C_TEXT:C284($2; $vt_tag)
C_POINTER:C301($3; $arrayToGet_Ptr)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/11/2014)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$xml_Ref:=$1
	$vt_tag:=$2
	$arrayToGet_Ptr:=$3
	
	C_TEXT:C284($vt_valueToGet)
	$vt_valueToGet:=OT_GetText($xml_Ref; $vt_tag)
	$vt_valueToGet:=STR_Base64_Decode($vt_valueToGet)
	
	ARRAY TEXT:C222($at_values; 0)
	Array_ConvertFromTextDelimited(->$at_values; $vt_valueToGet; Char:C90(Tab:K15:37))
	
	// Copy the array to our return value
	C_LONGINT:C283($i)
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
	
End if   // ASSERT