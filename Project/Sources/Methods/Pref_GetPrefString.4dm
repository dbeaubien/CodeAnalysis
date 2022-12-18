//%attributes = {"invisible":true,"preemptive":"capable"}
// Pref_GetPrefString (prefName {;default value}) : preference
// Pref_GetPrefString (text {;text}) : text
//
// DESCRIPTION
//   Fetches the named profile from the preference file in the resources.
//
C_TEXT:C284($1; $vt_prefName)
C_TEXT:C284($2; $vt_defaultValue)
C_TEXT:C284($0; $vt_value)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (09/19/2012, 19:42:57)
// ----------------------------------------------------

$vt_value:=""
If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	$vt_prefName:=$1
	If (Count parameters:C259>=2)
		$vt_defaultValue:=$2
	Else 
		$vt_defaultValue:=""
	End if 
	
	C_BOOLEAN:C305($vb_forceDefaultToBeSaved)
	$vb_forceDefaultToBeSaved:=False:C215
	
	C_TEXT:C284($vt_prefNameAsDigest)
	$vt_prefNameAsDigest:="Pref_"+STR_Base64_Encode($vt_prefName)
	$vt_prefNameAsDigest:=Replace string:C233($vt_prefNameAsDigest; "="; "")  // strip out the illegal characters
	
	// Ensure the folder exists
	C_TEXT:C284($vt_pathToPrefFile)
	$vt_pathToPrefFile:=Pref__GetFile2PrefFile
	
	// Ensure the file exists
	If (File_DoesExist($vt_pathToPrefFile))
		C_TEXT:C284($xml_Ref_s16)
		C_TEXT:C284($xml_found_s16)
		$xml_Ref_s16:=DOM Parse XML source:C719($vt_pathToPrefFile)
		If (OK=1)
			$xml_found_s16:=DOM Find XML element:C864($xml_Ref_s16; "/Root/"+$vt_prefNameAsDigest)
			If (OK=1)  // value was found?
				C_TEXT:C284($vt_CDATA_value)
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
		Pref_SetPrefString($vt_prefName; $vt_defaultValue)
	End if 
	
End if   // ASSERT
$0:=$vt_value