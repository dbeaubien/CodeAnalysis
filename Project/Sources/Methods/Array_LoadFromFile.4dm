//%attributes = {"invisible":true}
// Array_LoadFromFile (arrayPtr; filePath) : err
// Array_LoadFromFile (pointer; text) : longint
// 
// DESCRIPTION
//   Loads the variable from the specified file path.
//
C_POINTER:C301($1; $vp_arrayPtr)
C_TEXT:C284($2; $vt_saveToFilePath)
C_LONGINT:C283($0; $vl_err)
// ----------------------------------------------------
// CALLED BY
//   MethodStats__LoadFromDisk
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/20/2014)
// ----------------------------------------------------

$vl_err:=0
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$vp_arrayPtr:=$1
	$vt_saveToFilePath:=$2
	
	Array_Empty($vp_arrayPtr)
	
	If (File_DoesExist($vt_saveToFilePath))
		C_TEXT:C284($vt_onErrorMethod)  //   Mod by: Dani Beaubien (06/22/2013)
		$vt_onErrorMethod:=Method called on error:C704
		OnErr_ClearError
		ON ERR CALL:C155("OnErr_GENERIC")  //   Mod by: Dani Beaubien (08/13/2013)
		
		
		// Load from disk
		C_BLOB:C604($vx_binaryData)
		DOCUMENT TO BLOB:C525($vt_saveToFilePath; $vx_binaryData)
		
		BLOB TO VARIABLE:C533($vx_binaryData; $vp_arrayPtr->)
		
		$vl_err:=OnErr_GetLastError
		OnErr_ClearError  //   Mod by: Dani Beaubien (06/22/2013)
		ON ERR CALL:C155($vt_onErrorMethod)  // restore our method
	Else 
		$vl_err:=-43  // File not found
	End if 
End if   // ASSERT
$0:=$vl_err