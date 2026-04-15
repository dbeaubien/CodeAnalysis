//%attributes = {"invisible":true}
// Folder_MakePathRelativeToStruct (FilePath) : FilePathReleativeToStructure
// Folder_MakePathRelativeToStruct (text) : text
//
// DESCRIPTION
//   Converts the passed path into one that is relative
//   to the structure.
//
var $1; $vt_filePath : Text
var $0; $vt_relativePath : Text
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (04/12/2014)
// ----------------------------------------------------

$vt_relativePath:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_filePath:=$1
	
	var $vt_pathToStructureFolder : Text
	$vt_pathToStructureFolder:=Folder_ParentName(Structure file:C489(*))
	
	// Does the path a subfolder of the structure's folder
	If ($vt_filePath=($vt_pathToStructureFolder+"@"))
		$vt_relativePath:=Folder separator:K24:12+Substring:C12($vt_filePath; Length:C16($vt_pathToStructureFolder)+1)  // Remove the structure's path
	Else 
		$vt_relativePath:=""  // Needs to be within the structure folder
	End if 
	
	If ($vt_relativePath#"") & ($vt_relativePath#Folder separator:K24:12)
		$vt_relativePath:="{StructFldr}"+$vt_relativePath
		
		If ($vt_relativePath=("@"+Folder separator:K24:12))
			$vt_relativePath:=Substring:C12($vt_relativePath; 1; Length:C16($vt_relativePath)-1)
		End if 
		
	Else 
		$vt_relativePath:=""  // Ensure it is blank
	End if 
	
End if 
$0:=$vt_relativePath