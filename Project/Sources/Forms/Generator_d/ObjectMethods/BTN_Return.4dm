
If (FORM Get current page:C276=1)  // on DIFF tab
	C_TEXT:C284(<>_DIFF_MethodName; <>_DIFF_PathToFileOnDisk)
	<>_DIFF_MethodName:=selectedDiffMethod.methodName
	<>_DIFF_PathToFileOnDisk:=selectedDiffMethod.methodPathOnDisk
	
	CODE_DoMethodDiff
End if 
