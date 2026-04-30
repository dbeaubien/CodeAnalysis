//%attributes = {"invisible":true}
// File_GetFileName (filePath) : filename
//
// DESCRIPTION
//   Given the path to a document, returns the document itself.
//
#DECLARE($file_platformPath : Text)->$file_name : Text
//---------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$file_name:=""

Case of 
	: ($file_platformPath="")
		$file_name:=""
		
	: ($file_platformPath=(Folder separator:K24:12+"@"))
		$file_name:=""
		
	Else 
		var $parts : Collection
		$parts:=Split string:C1554($file_platformPath; Folder separator:K24:12)
		$file_name:=$parts.pop()
End case 
