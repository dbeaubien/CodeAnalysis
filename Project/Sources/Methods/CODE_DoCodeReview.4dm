//%attributes = {"invisible":true}
// CODE_DoCodeReview
//
// DESCRIPTION
//   Does a comparison between the stored method and
//   the method on disk. Specified by the interprocess vars:
//   <>_DIFF_MethodName and <>_DIFF_PathToFileOnDisk.
//
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/01/2012)
// ----------------------------------------------------


If (Process_LaunchAsNew(Current method name:C684; <>_DIFF_MethodName))
	var _DIFF_MethodName; <>_DIFF_MethodName : Text
	_DIFF_MethodName:=<>_DIFF_MethodName
	<>_DIFF_MethodName:=""
	
	var $NIL_p : Pointer
	var $vt_windowTitle : Text
	$vt_windowTitle:="Code Review: "+_DIFF_MethodName
	WIN_Dialog($NIL_p; "CodeReview_d"; Plain window:K34:13; $vt_windowTitle; On the left:K39:2; At the top:K39:5)
End if 
