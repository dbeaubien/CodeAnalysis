//%attributes = {"invisible":true}
// CODE_DoMethodDiff (parm1, parm2) : result
// CODE_DoMethodDiff (parm1, parm2) : result
//
// DESCRIPTION
//   Does a comparison between the stored method and
//   the method on disk. Specified by the interprocess vars:
//   <>_DIFF_MethodName and <>_DIFF_PathToFileOnDisk.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/01/2012)
//   Mod: DB (01/19/2015) - prepend the process name with "diff:" so that we know it is unique
// ----------------------------------------------------


If (Process_LaunchAsNew(Current method name:C684; "diff:"+<>_DIFF_MethodName))  //   Mod: DB (01/19/2015)
	
	C_TEXT:C284(_DIFF_MethodName; <>_DIFF_MethodName)
	_DIFF_MethodName:=<>_DIFF_MethodName
	<>_DIFF_MethodName:=""
	
	C_TEXT:C284(_DIFF_PathToFileOnDisk; <>_DIFF_PathToFileOnDisk)
	_DIFF_PathToFileOnDisk:=<>_DIFF_PathToFileOnDisk
	<>_DIFF_PathToFileOnDisk:=""
	
	C_POINTER:C301($NIL_p)
	C_TEXT:C284($vt_windowTitle)
	$vt_windowTitle:="DIFF: "+_DIFF_MethodName
	WIN_Dialog($NIL_p; "MethodDifferences_d"; Plain window:K34:13; $vt_windowTitle; On the left:K39:2; At the top:K39:5)
	
End if 
