//%attributes = {"invisible":true}
// MethodDiff_d_ApplyCodePrefs (srcMethodCode) : trimmedMethodCode
// MethodDiff_d_ApplyCodePrefs (text) : text
//
// DESCRIPTION
//   Handle the configuration checkboxes on the dialog
//
C_TEXT:C284($1; $vt_srcMethodCode)
C_TEXT:C284($0; $vt_trimmedMethodCode)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/30/2012)
// ----------------------------------------------------

$vt_trimmedMethodCode:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_srcMethodCode:=$1
	
	$vt_trimmedMethodCode:=$vt_srcMethodCode
	
	If ($vt_trimmedMethodCode#"")
		
		// Normalize the EOL
		C_TEXT:C284($vt_theEOL)
		$vt_theEOL:=STR_TellMeTheEOL($vt_trimmedMethodCode)
		If ($vt_theEOL#Pref_GetEOL)  // make sure we are using a comming EOL
			$vt_trimmedMethodCode:=Replace string:C233($vt_trimmedMethodCode; $vt_theEOL; Pref_GetEOL)
		End if 
		
		// ### Handle the configuration checkboxes on the dialog
		If (Pref_GetPrefString("DIFF HideComments")="Yes")  //   Mod: DB (03/29/2014) 
			$vt_trimmedMethodCode:=MethodCode_RemoveAllComments($vt_trimmedMethodCode)
		Else 
			If (Pref_GetPrefString("DIFF HideAttributeLine")="Yes")  //   Mod: DB (03/29/2014) 
				$vt_trimmedMethodCode:=MethodCode_RemoveAttributeLine($vt_trimmedMethodCode)
			End if 
		End if 
		If (Pref_GetPrefString("DIFF HideBlankLines")="Yes")  //   Mod: DB (03/29/2014) 
			$vt_trimmedMethodCode:=MethodCode_RemoveBlankLines($vt_trimmedMethodCode)
		End if 
		
	End if 
	
End if   // ASSERT
$0:=$vt_trimmedMethodCode
