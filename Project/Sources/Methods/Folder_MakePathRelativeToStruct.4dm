//%attributes = {"invisible":true}
// Folder_MakePathRelativeToStruct (FilePath) : FilePathReleativeToStructure
//
// DESCRIPTION
//   Converts the passed path into one that is relative
//   to the structure.
//
#DECLARE($file_platformPath : Text)->$relative_path : Text
// ----------------------------------------------------

$relative_path:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	
	var $structureFldr_platformPath : Text
	$structureFldr_platformPath:=Folder_ParentName(Structure file:C489(*))
	
	// Does the path a subfolder of the structure's folder
	If ($file_platformPath=($structureFldr_platformPath+"@"))
		$relative_path:=Folder separator:K24:12+Substring:C12($file_platformPath; Length:C16($structureFldr_platformPath)+1)  // Remove the structure's path
	Else 
		$relative_path:=""  // Needs to be within the structure folder
	End if 
	
	If ($relative_path#"") & ($relative_path#Folder separator:K24:12)
		$relative_path:="{StructFldr}"+$relative_path
		
		If ($relative_path=("@"+Folder separator:K24:12))
			$relative_path:=Substring:C12($relative_path; 1; Length:C16($relative_path)-1)
		End if 
		
	Else 
		$relative_path:=""  // Ensure it is blank
	End if 
	
End if 
