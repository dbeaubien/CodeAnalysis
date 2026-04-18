//%attributes = {"invisible":true}
// CODE_DoMethodDiff (parm1, parm2) : result
//
// DESCRIPTION
//   Does a comparison between the stored method and
//   the method on disk. Specified by the interprocess vars:
//   <>_DIFF_MethodName and <>_DIFF_PathToFileOnDisk.
//
// ----------------------------------------------------

If (Process_LaunchAsNew(Current method name:C684; "diff:"+<>_DIFF_MethodName))  //   Mod: DB (01/19/2015)
	
	var _DIFF_MethodName; <>_DIFF_MethodName : Text
	_DIFF_MethodName:=<>_DIFF_MethodName
	<>_DIFF_MethodName:=""
	
	var _DIFF_PathToFileOnDisk; <>_DIFF_PathToFileOnDisk : Text
	_DIFF_PathToFileOnDisk:=<>_DIFF_PathToFileOnDisk
	<>_DIFF_PathToFileOnDisk:=""
	
	var $NIL_p : Pointer
	var $vt_windowTitle : Text
	$vt_windowTitle:="DIFF: "+_DIFF_MethodName
	WIN_Dialog($NIL_p; "MethodDifferences_d"; Plain window:K34:13; $vt_windowTitle; On the left:K39:2; At the top:K39:5)
	
End if 
