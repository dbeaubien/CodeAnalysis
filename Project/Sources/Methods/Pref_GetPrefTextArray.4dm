//%attributes = {"invisible":true}
// Pref_GetPrefTextArray (prefName; textArray)
// Pref_GetPrefTextArray (text ;pointer)
//
// DESCRIPTION
//   Retrieves the contents of the array from the local
//   structure specific preference file.
//
C_TEXT:C284($1; $vt_prefName)
C_POINTER:C301($2; $at_textArrayPtr)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (04/12/2014)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$vt_prefName:=$1
	$at_textArrayPtr:=$2
	Array_Empty($at_textArrayPtr)
	
	C_TEXT:C284($vt_Value)
	$vt_Value:=Pref_GetPrefString($vt_prefName)
	
	ARRAY_Unpack($vt_Value; $at_textArrayPtr; ",")
	
	// Loop through all the values and turn into a comma delimted file
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($at_textArrayPtr->))
		$at_textArrayPtr->{$i}:=STR_URLDecode($at_textArrayPtr->{$i})
		If ($at_textArrayPtr->{$i}="{@}")
			$at_textArrayPtr->{$i}:=Substring:C12($at_textArrayPtr->{$i}; 2; Length:C16($at_textArrayPtr->{$i})-2)
		End if 
	End for 
	
End if 