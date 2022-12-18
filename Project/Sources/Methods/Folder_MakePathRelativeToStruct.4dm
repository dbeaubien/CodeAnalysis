//%attributes = {"invisible":true}
// Folder_MakePathRelativeToStruct (FilePath) : FilePathReleativeToStructure
// Folder_MakePathRelativeToStruct (text) : text
//
// DESCRIPTION
//   Converts the passed path into one that is relative
//   to the structure.
//
C_TEXT:C284($1; $vt_filePath)
C_TEXT:C284($0; $vt_relativePath)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (04/12/2014)
// ----------------------------------------------------

$vt_relativePath:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_filePath:=$1
	
	C_TEXT:C284($vt_pathToStructureFolder)
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
	
End if   // ASSERT
$0:=$vt_relativePath