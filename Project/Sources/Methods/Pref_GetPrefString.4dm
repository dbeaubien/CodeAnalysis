//%attributes = {"invisible":true,"preemptive":"capable"}
// Pref_GetPrefString (prefName {;default value}) : preference
//
// DESCRIPTION
//   Fetches the named profile from the preference file in the resources.
//
#DECLARE($prefName : Text; $defaultValue : Text)->$value : Text
// ----------------------------------------------------
$value:=""

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	var $forceDefaultToBeSaved : Boolean
	$forceDefaultToBeSaved:=False:C215
	
	var $prefNameAsDigest : Text
	$prefNameAsDigest:="Pref_"+STR_Base64_Encode($prefName)
	$prefNameAsDigest:=Replace string:C233($prefNameAsDigest; "="; "")  // strip out the illegal characters
	
	// Ensure the folder exists
	var $pathToPrefFile : Text
	$pathToPrefFile:=Pref__GetFile2PrefFile
	
	// Ensure the file exists
	If (File_DoesExist($pathToPrefFile))
		var $xml_Ref_s16 : Text
		var $xml_found_s16 : Text
		$xml_Ref_s16:=DOM Parse XML source:C719($pathToPrefFile)
		If (OK=1)
			$xml_found_s16:=DOM Find XML element:C864($xml_Ref_s16; "/Root/"+$prefNameAsDigest)
			If (OK=1)  // value was found?
				var $CDATA_value : Text
				//DOM GET XML ELEMENT VALUE($xml_found_s16;$value;$CDATA_value)
				DOM GET XML ELEMENT VALUE:C731($xml_found_s16; $value; $CDATA_value)
				$value:=$value+$CDATA_value
			Else 
				$forceDefaultToBeSaved:=True:C214
			End if 
			DOM CLOSE XML:C722($xml_Ref_s16)
		End if 
		
	Else 
		$forceDefaultToBeSaved:=True:C214
	End if 
	
	If ($forceDefaultToBeSaved)
		$value:=$defaultValue  // start with the default value
		Pref_SetPrefString($prefName; $defaultValue)
	End if 
	
End if 
