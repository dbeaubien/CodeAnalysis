//%attributes = {"invisible":true}
// MethodStats__GatherParmInfo2
//
// DESCRIPTION
//   Appends the parameters as a parameter for the specified
//   Method. 
//
#DECLARE($vp_parmsObjPtr : Pointer\
; $vt_parmText : Text\
; $vt_parmType : Text\
; $vt_localVarName : Text\
; $vt_comment : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 5; Count parameters:C259))
	$vt_comment:=Replace string:C233($vt_comment; "//"; "")
	$vt_comment:=STR_TrimExcessSpaces($vt_comment)
	
	var $vt_indexStr : Text
	$vt_indexStr:=$vt_parmText+Char:C90(Tab:K15:37)  //   Mod: DB (11/21/2013) - Added padding zeros so that it sorts properly
	
	var $vl_parmNo : Integer
	$vl_parmNo:=Num:C11($vt_parmText)
	
	// Setup our parm details
	var $vo_parmObj : Object
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