//%attributes = {"invisible":true}
// Array_SaveToFile (arrayPtr; filePath) : err
// 
// DESCRIPTION
//   Saves the variable to the specified file path.
//
#DECLARE($vp_arrayPtr : Pointer; $vt_saveToFilePath : Text)->$vl_err : Integer
// ----------------------------------------------------
$vl_err:=0

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	var $vt_onErrorMethod : Text  //   Mod by: Dani Beaubien (06/22/2013)
	$vt_onErrorMethod:=Method called on error:C704
	OnErr_ClearError
	ON ERR CALL:C155("OnErr_GENERIC")  //   Mod by: Dani Beaubien (08/13/2013)
	
	var $vx_binaryData : Blob
	VARIABLE TO BLOB:C532($vp_arrayPtr->; $vx_binaryData)
	
	File_Delete($vt_saveToFilePath)
	
	// Save to disk
	BLOB TO DOCUMENT:C526($vt_saveToFilePath; $vx_binaryData)
	
	$vl_err:=OnErr_GetLastError
	OnErr_ClearError  //   Mod by: Dani Beaubien (06/22/2013)
	ON ERR CALL:C155($vt_onErrorMethod)  // restore our method
End if 
