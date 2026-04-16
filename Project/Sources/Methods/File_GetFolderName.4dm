//%attributes = {"invisible":true}
// File_GetFolderName (filePath) : parentFolderPath
// 
// DESCRIPTION
//   Given the path to a document, returns the path
//   to the folder the document is in.
//
#DECLARE($t_docPath : Text)->$t_folderPath : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

$t_folderPath:=$t_docPath  // be default

var $l_length; $l_position : Integer
$l_position:=0
$l_length:=Length:C16($t_docPath)

var $vt_directorySymbol : Text
$vt_directorySymbol:=Folder separator:K24:12

If ($l_length>2)
	var $i : Integer
	For ($i; $l_length-1; 1; -1)
		If ($t_docPath[[$i]]=$vt_directorySymbol)
			$l_position:=$i
			$i:=0
		End if 
	End for 
	
	If ($l_position>0)
		$t_folderPath:=Substring:C12($t_docPath; 1; $l_position)
	Else 
		$t_folderPath:=""  // no parent so return empty string
	End if 
	
Else 
	$t_folderPath:=""  // no parent so return empty string
End if 
