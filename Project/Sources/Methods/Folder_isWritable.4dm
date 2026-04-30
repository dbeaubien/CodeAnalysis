//%attributes = {"invisible":true}
// Folder_isWritable (folderPath) : isWritable
// 
// DESCRIPTION
//   Returns true is the folder is writable.
//
#DECLARE($folder_platformPath : Text)->$isWritable : Boolean
// ----------------------------------------------------
$isWritable:=False:C215

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	var $onErrorMethod : Text  //   Mod by: Dani Beaubien (06/22/2013)
	$onErrorMethod:=Method called on error:C704
	OnErr_ClearError
	ON ERR CALL:C155("OnErr_GENERIC")  //   Mod by: Dani Beaubien (08/13/2013)
	
	Folder_VerifyExistance($folder_platformPath)
	If (OnErr_GetLastError=0)
		var $tmpFileName : Text
		$tmpFileName:=String:C10(Milliseconds:C459)+Date2String(Current date:C33; "yymmdd")
		
		var $docRef : Time
		$docRef:=Create document:C266($folder_platformPath+$tmpFileName)
		If (OK=1)
			$isWritable:=True:C214
			CLOSE DOCUMENT:C267($docRef)
			File_Delete($folder_platformPath+$tmpFileName)
		End if 
	End if 
	
	OnErr_ClearError  //   Mod by: Dani Beaubien (06/22/2013)
	ON ERR CALL:C155($onErrorMethod)  // restore our method
End if 
