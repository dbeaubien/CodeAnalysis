
If (FORM Get current page:C276=1)  // on DIFF tab
	var <>_DIFF_MethodName; <>_DIFF_PathToFileOnDisk : Text
	<>_DIFF_MethodName:=selectedDiffMethod.methodName
	<>_DIFF_PathToFileOnDisk:=selectedDiffMethod.methodPathOnDisk
	
	CODE_DoMethodDiff
End if 
