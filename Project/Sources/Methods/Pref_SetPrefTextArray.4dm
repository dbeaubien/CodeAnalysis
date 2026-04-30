//%attributes = {"invisible":true}
// Pref_SetPrefTextArray (prefName; textArray)
//
// DESCRIPTION
//   Stores the contents of the array into the local
//   structure specific preference file.
//
#DECLARE($vt_prefName : Text; $at_textArrayPtr : Pointer)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	var $vt_Value : Text
	$vt_Value:=""
	
	// Loop through all the values and turn into a comma delimted file
	var $i : Integer
	For ($i; 1; Size of array:C274($at_textArrayPtr->))
		If ($i>1)
			$vt_Value:=$vt_Value+","
		End if 
		$vt_Value:=$vt_Value+"{"+STR_URLEncode($at_textArrayPtr->{$i})+"}"
	End for 
	
	Pref_SetPrefString($vt_prefName; $vt_Value)
End if 