//%attributes = {"invisible":true}
// CHART_SaveAsGIF
// 
#DECLARE($chartID : Text; $vt_filePath : Text)
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	// Make sure that there is no file there already
	File_Delete($vt_filePath)
	
	SVG_SAVE_AS_PICTURE(CHART_SVG_GetMasterRef($chartID); $vt_filePath; ".gif")
End if 
