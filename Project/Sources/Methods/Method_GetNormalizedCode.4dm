//%attributes = {"invisible":true}
// Method_GetNormalizedCode (methodName{; collapseLines}) : normalizedMethodCode
//
#DECLARE($vt_methodName : Text; $vb_collapseLines : Boolean)->$vt_normalizedCode : Text
// ----------------------------------------------------
$vt_normalizedCode:=""

Logging_Method_START(Current method name:C684)
If (DEV_ASSERT_PARMCOUNT_RANGE(Current method name:C684; 1; 2; Count parameters:C259))
	
	// Fetch the method code
	METHOD GET CODE:C1190($vt_methodName; $vt_normalizedCode; *)
	
	var $vt_EOL_Target; $vt_EOL_Current : Text
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
End if 

Logging_Method_STOP(Current method name:C684)