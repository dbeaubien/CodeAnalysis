//%attributes = {"invisible":true}
// ----------------------------------------------------
// MethodStats__GatherParmInfo2
//
// DESCRIPTION
//   Appends the parameters as a parameter for the specified
//   Method. 
//
C_POINTER:C301($1; $vp_parmsObjPtr)
C_TEXT:C284($2; $vt_parmText)  // The parm text
C_TEXT:C284($3; $vt_parmType)  // A text string representing the type of the parm.
C_TEXT:C284($4; $vt_localVarName)  // the local variable that the parameter is linked with.
C_TEXT:C284($5; $vt_comment)  // A comment that describes the parameter.
// ----------------------------------------------------
// CALLED BY
//   MethodStats__GatherParmInfo
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (03/12/2012)
//   Mod: DB (11/21/2013) - Added padding zeros so that it sorts properly
//   Mod: DB (04/25/2016) - rewritten to use json objects
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 5; Count parameters:C259))
	$vp_parmsObjPtr:=$1
	$vt_parmText:=$2
	$vt_parmType:=$3
	$vt_localVarName:=$4
	$vt_comment:=Replace string:C233($5; "//"; "")
	$vt_comment:=STR_TrimExcessSpaces($vt_comment)
	
	
	C_TEXT:C284($vt_indexStr)
	$vt_indexStr:=$vt_parmText+Char:C90(Tab:K15:37)  //   Mod: DB (11/21/2013) - Added padding zeros so that it sorts properly
	
	C_LONGINT:C283($vl_parmNo)
	$vl_parmNo:=Num:C11($vt_parmText)
	
	// Setup our parm details
	C_OBJECT:C1216($vo_parmObj)
	If (OB Is defined:C1231($vp_parmsObjPtr->; "parm"+String:C10($vl_parmNo)))
		$vo_parmObj:=OB Get:C1224($vp_parmsObjPtr->; "parm"+String:C10($vl_parmNo); Is object:K8:27)
	Else 
		$vo_parmObj:=New object:C1471
	End if 
	$vo_parmObj.parm:=$vt_parmText
	$vo_parmObj.cType:=$vt_parmType
	$vo_parmObj.lvar:=$vt_localVarName
	$vo_parmObj.rem:=$vt_comment
	
	// Track the highest parm number
	If ($vl_parmNo>OB Get:C1224($vp_parmsObjPtr->; "maxParmNo"; Is longint:K8:6))
		OB SET:C1220($vp_parmsObjPtr->; "maxParmNo"; $vl_parmNo)
	End if 
	
	// update the details on the specific parm
	OB SET:C1220($vp_parmsObjPtr->; "parm"+String:C10($vl_parmNo); $vo_parmObj)
	
End if 