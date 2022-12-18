//%attributes = {"invisible":true}
// OT_PutArray (objID; tag; ptrToArray)
// OT_PutArray (text; text; pointer)
// 
// DESCRIPTION
//   Put the array into the mock object under tag
//
C_TEXT:C284($1; $xml_Ref)
C_TEXT:C284($2; $vt_tag)
C_POINTER:C301($3; $arrayToPut_Ptr)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/11/2014)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$xml_Ref:=$1
	$vt_tag:=$2
	$arrayToPut_Ptr:=$3
	
	ARRAY TEXT:C222($at_values; Size of array:C274($arrayToPut_Ptr->))
	Case of 
		: (Size of array:C274($at_values)=0)
			// NOTHING TO CONVERT
			
		: (Type:C295($arrayToPut_Ptr->)=Text array:K8:16)
			COPY ARRAY:C226($arrayToPut_Ptr->; $at_values)
			
		: (Type:C295($arrayToPut_Ptr->)=Date array:K8:20)
			C_LONGINT:C283($i)
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
	
	C_TEXT:C284($vt_valueToPut)
	$vt_valueToPut:=Array_ConvertToTextDelimited(->$at_values; Char:C90(Tab:K15:37))
	$vt_valueToPut:=STR_Base64_Encode($vt_valueToPut)
	
	OT_PutText($xml_Ref; $vt_tag; $vt_valueToPut)
End if   // ASSERT