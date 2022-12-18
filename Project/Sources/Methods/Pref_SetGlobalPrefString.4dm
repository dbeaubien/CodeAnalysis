//%attributes = {"invisible":true}
// Pref_SetGlobalPrefString (prefName; value)
// Pref_SetGlobalPrefString (text ;text)
//
// DESCRIPTION
//   Fetches the named profile from the global preference
//   file in the resources.
//
C_TEXT:C284($1; $vt_prefName)
C_TEXT:C284($2; $vt_Value)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (09/19/2012, 19:42:57)
//   Mod by: Dani Beaubien (01/26/2013) - Make it easier for a user to view the xml file directly.
// ----------------------------------------------------

$vt_value:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$vt_prefName:=$1
	$vt_Value:=$2
	
	C_TEXT:C284($vt_prefNameAsDigest)
	$vt_prefNameAsDigest:="Pref_"+STR_Base64_Encode($vt_prefName)
	$vt_prefNameAsDigest:=Replace string:C233($vt_prefNameAsDigest; "="; "")  // strip out the illegal characters
	
	// Ensure the folder exists
	C_TEXT:C284($vt_pathToPrefFile)
	$vt_pathToPrefFile:=Pref__GetFile2GlobalPrefFile
	
	// Setup our DOM
	C_TEXT:C284($xml_Ref_s16)
	If (File_DoesExist($vt_pathToPrefFile))
		$xml_Ref_s16:=DOM Parse XML source:C719($vt_pathToPrefFile)  // Load the file from disk
	Else 
		$xml_Ref_s16:=DOM Create XML Ref:C861("Root")  // No file, create new DOM
	End if 
	
	// Everything okay, then continue
	If (OK=1)
		//DOM SET XML ELEMENT VALUE($xml_Ref_s16;"/Root/"+$vt_prefNameAsDigest;$vt_value;*)
		DOM SET XML ELEMENT VALUE:C868($xml_Ref_s16; "/Root/"+$vt_prefNameAsDigest; $vt_value)
		
		C_TEXT:C284($xml_pref)
		$xml_pref:=DOM Find XML element:C864($xml_Ref_s16; "/Root/"+$vt_prefNameAsDigest)
		DOM SET XML ATTRIBUTE:C866($xml_pref; "PrefLabel"; $vt_prefName)  //   Mod by: Dani Beaubien (01/26/2013) - Make it easier for a user to view the xml file directly.
		
		If (OK=1)
			DOM EXPORT TO FILE:C862($xml_Ref_s16; $vt_pathToPrefFile)  // Save the file from disk
		End if 
		
		DOM CLOSE XML:C722($xml_Ref_s16)
	End if 
End if   // ASSERT
