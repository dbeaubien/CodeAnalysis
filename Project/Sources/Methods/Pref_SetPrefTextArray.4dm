//%attributes = {"invisible":true}
// Pref_SetPrefTextArray (prefName; textArray)
// Pref_SetPrefTextArray (text ;pointer)
//
// DESCRIPTION
//   Stores the contents of the array into the local
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
	
	C_TEXT:C284($vt_Value)
	$vt_Value:=""
	
	// Loop through all the values and turn into a comma delimted file
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274($at_textArrayPtr->))
		If ($i>1)
			$vt_Value:=$vt_Value+","
		End if 
		$vt_Value:=$vt_Value+"{"+STR_URLEncode($at_textArrayPtr->{$i})+"}"
	End for 
	
	Pref_SetPrefString($vt_prefName; $vt_Value)
End if 