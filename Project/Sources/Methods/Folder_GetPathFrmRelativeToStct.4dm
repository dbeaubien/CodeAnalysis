//%attributes = {"invisible":true}
// Folder_GetPathFrmRelativeToStct (FilePathReleativeToStructure) : FilePath
// Folder_GetPathFrmRelativeToStct (text) : text
//
// DESCRIPTION
//   Converts the passed path from one that is relative
//   to the structure into one that is accurate for the disk.
//
C_TEXT:C284($1; $vt_relativePath)
C_TEXT:C284($0; $vt_filePath)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (04/12/2014)
// ----------------------------------------------------

$vt_filePath:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_relativePath:=$1
	
	If ($vt_relativePath=("{StructFldr}"+Folder separator:K24:12+"@"))
		$vt_filePath:=Substring:C12($vt_relativePath; Length:C16("{StructFldr}"+Folder separator:K24:12)+1)  // remove our token text
		$vt_filePath:=Folder_ParentName(Structure file:C489(*))+$vt_filePath
	End if 
	
End if   // ASSERT
$0:=$vt_filePath