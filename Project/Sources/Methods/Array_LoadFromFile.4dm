//%attributes = {"invisible":true}
// Array_LoadFromFile (arrayPtr; filePath) : err
// 
// DESCRIPTION
//   Loads the variable from the specified file path.
//
#DECLARE($array_ptr : Pointer; $vt_saveToFilePath : Text)->$vl_err : Integer
// ----------------------------------------------------
$vl_err:=0

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	Array_Empty($array_ptr)
	
	If (File_DoesExist($vt_saveToFilePath))
		var $vt_onErrorMethod : Text  //   Mod by: Dani Beaubien (06/22/2013)
		$vt_onErrorMethod:=Method called on error:C704
		OnErr_ClearError
		ON ERR CALL:C155("OnErr_GENERIC")  //   Mod by: Dani Beaubien (08/13/2013)
		
		
		// Load from disk
		var $vx_binaryData : Blob
		DOCUMENT TO BLOB:C525($vt_saveToFilePath; $vx_binaryData)
		
		BLOB TO VARIABLE:C533($vx_binaryData; $array_ptr->)
		
		$vl_err:=OnErr_GetLastError
		OnErr_ClearError  //   Mod by: Dani Beaubien (06/22/2013)
		ON ERR CALL:C155($vt_onErrorMethod)  // restore our method
	Else 
		$vl_err:=-43  // File not found
	End if 
End if 
