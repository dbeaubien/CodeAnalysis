//%attributes = {"invisible":true}
// Folder_isWritable (folderPath) : isWritable
// Folder_isWritable (text) : boolean
// 
// DESCRIPTION
//   Returns true is the folder is writable.
//
C_TEXT:C284($1; $vt_folderPath)
C_BOOLEAN:C305($0; $vb_isWritable)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/11/2014)
// ----------------------------------------------------

$vb_isWritable:=False:C215
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_folderPath:=$1
	
	C_TEXT:C284($vt_onErrorMethod)  //   Mod by: Dani Beaubien (06/22/2013)
	$vt_onErrorMethod:=Method called on error:C704
	OnErr_ClearError
	ON ERR CALL:C155("OnErr_GENERIC")  //   Mod by: Dani Beaubien (08/13/2013)
	
	Folder_VerifyExistance($vt_folderPath)
	If (OnErr_GetLastError=0)
		C_TEXT:C284($vt_tmpFileName)
		$vt_tmpFileName:=String:C10(Milliseconds:C459)+Date2String(CurrentDate; "yymmdd")
		
		C_TIME:C306($vh_docRef)
		$vh_docRef:=Create document:C266($vt_folderPath+$vt_tmpFileName)
		If (OK=1)
			$vb_isWritable:=True:C214
			CLOSE DOCUMENT:C267($vh_docRef)
			File_Delete($vt_folderPath+$vt_tmpFileName)
		End if 
	End if 
	
	OnErr_ClearError  //   Mod by: Dani Beaubien (06/22/2013)
	ON ERR CALL:C155($vt_onErrorMethod)  // restore our method
End if   // ASSERT
$0:=$vb_isWritable