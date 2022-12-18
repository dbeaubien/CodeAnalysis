//%attributes = {"invisible":true}
// Method_GetNormalizedCode (methodName{; collapseLines}) : normalizedMethodCode
// Method_GetNormalizedCode (text{; boolean}) : text
//
// DESCRIPTION
//   
//
C_TEXT:C284($1; $vt_methodName)
C_BOOLEAN:C305($2; $vb_collapseLines)  // OPTIONAL, set to true to collapse multi-lines
C_TEXT:C284($0; $vt_normalizedCode)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (02/17/2014)
//   Mod: DB (01/15/2016) - Added collapseLines
// ----------------------------------------------------

$vt_normalizedCode:=""
Logging_Method_START(Current method name:C684)
If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	$vt_methodName:=$1
	If (Count parameters:C259>=2)
		$vb_collapseLines:=$2
	End if 
	
	// Fetch the method code
	METHOD GET CODE:C1190($vt_methodName; $vt_normalizedCode; *)
	
	C_TEXT:C284($vt_EOL_Target; $vt_EOL_Current)
	$vt_EOL_Target:=Pref_GetEOL
	$vt_EOL_Current:=STR_TellMeTheEOL($vt_normalizedCode)
	
	// If the EOLs are not what we want, then convert them
	If ($vt_EOL_Current#$vt_EOL_Target)
		$vt_normalizedCode:=Replace string:C233($vt_normalizedCode; $vt_EOL_Current; $vt_EOL_Target)
	End if 
	
	If ($vb_collapseLines)
		$vt_normalizedCode:=Replace string:C233($vt_normalizedCode; "\\"+$vt_EOL_Target; "")
	End if 
	
	//   Mod: DB (04/26/2017) - Remove any embedded tabs. v16 uses them for indenting
	$vt_normalizedCode:=Replace string:C233($vt_normalizedCode; "\t"; "")
	//$vt_normalizedCode:=Replace string($vt_normalizedCode;$vt_EOL_Target+"  //";$vt_EOL_Target+"//")
	//If ($vt_normalizedCode="  //@")
	//$vt_normalizedCode:=Substring($vt_normalizedCode;3;Length($vt_normalizedCode)-2)
	//End if 
End if   // ASSERT
Logging_Method_STOP(Current method name:C684)
$0:=$vt_normalizedCode