//%attributes = {"invisible":true}
// Pref_GetGlobalPrefString (prefName {;default value}) : preference
//
// DESCRIPTION
//   Fetches the named profile from the global preference
//   file in the resources.
//
#DECLARE($vt_prefName : Text; $vt_defaultValue : Text)->$vt_value : Text
// ----------------------------------------------------
$vt_value:=""

If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	
	var $vb_forceDefaultToBeSaved : Boolean
	$vb_forceDefaultToBeSaved:=False:C215
	
	var $vt_prefNameAsDigest : Text
	$vt_prefNameAsDigest:="Pref_"+STR_Base64_Encode($vt_prefName)
	$vt_prefNameAsDigest:=Replace string:C233($vt_prefNameAsDigest; "="; "")  // strip out the illegal characters
	
	// Ensure the folder exists
	var $vt_pathToPrefFile : Text
	$vt_pathToPrefFile:=Pref__GetFile2GlobalPrefFile
	
	// Ensure the file exists
	If (File_DoesExist($vt_pathToPrefFile))
		var $xml_Ref_s16 : Text
		var $xml_found_s16; $vt_CDATA_value : Text
		$xml_Ref_s16:=DOM Parse XML source:C719($vt_pathToPrefFile)
		If (OK=1)
			$xml_found_s16:=DOM Find XML element:C864($xml_Ref_s16; "/Root/"+$vt_prefNameAsDigest)
			If (OK=1)  // value was found?
				//DOM GET XML ELEMENT VALUE($xml_found_s16;$vt_value;$vt_CDATA_value)
				DOM GET XML ELEMENT VALUE:C731($xml_found_s16; $vt_value; $vt_CDATA_value)
				$vt_value:=$vt_value+$vt_CDATA_value
			Else 
				$vb_forceDefaultToBeSaved:=True:C214
			End if 
			DOM CLOSE XML:C722($xml_Ref_s16)
		End if 
		
	Else 
		$vb_forceDefaultToBeSaved:=True:C214
	End if 
	
	If ($vb_forceDefaultToBeSaved)
		$vt_value:=$vt_defaultValue  // start with the default value
		Pref_SetGlobalPrefString($vt_prefName; $vt_defaultValue)
	End if 
	
End if 
