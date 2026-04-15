//%attributes = {"invisible":true}
// Pref_GetPrefTextArray (prefName; textArray)
//
// DESCRIPTION
//   Retrieves the contents of the array from the local
//   structure specific preference file.
//
#DECLARE($vt_prefName : Text; $at_textArrayPtr : Pointer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	Array_Empty($at_textArrayPtr)
	
	var $vt_Value : Text
	$vt_Value:=Pref_GetPrefString($vt_prefName)
	
	ARRAY_Unpack($vt_Value; $at_textArrayPtr; ",")
	
	// Loop through all the values and turn into a comma delimted file
	var $i : Integer
	For ($i; 1; Size of array:C274($at_textArrayPtr->))
		$at_textArrayPtr->{$i}:=STR_URLDecode($at_textArrayPtr->{$i})
		If ($at_textArrayPtr->{$i}="{@}")
			$at_textArrayPtr->{$i}:=Substring:C12($at_textArrayPtr->{$i}; 2; Length:C16($at_textArrayPtr->{$i})-2)
		End if 
	End for 
	
End if 