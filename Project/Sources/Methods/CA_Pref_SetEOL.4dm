//%attributes = {"invisible":true,"shared":true}
// CA_Pref_SetEOL (EOLchars)
// CA_Pref_SetEOL (text)
// 
// DESCRIPTION
//   This method sets the end-of-line character that is used
//   when exporting methods. 
//
//   Permited values are:
//    - an empty string; resets to platform default
//    - Char(Carriage Return)
//    - Char(Line feed)
//    - Char(Carriage Return)+Char(Line feed)
//
C_TEXT:C284($1; $vt_EOLchars)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/25/2017)
// ----------------------------------------------------


If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_EOLchars:=$1
	
	If (STR_IsOneOf($vt_EOLchars; "\r"; "\n"; "\r\n"; ""))
		Pref_SetEOL($vt_EOLchars)
	Else 
		ALERT:C41(Current method name:C684+" only supports \"\\r\", \"\\n\", \"\\r\\n\", or \"\".")
	End if 
	
End if   // ASSERT
