//%attributes = {"invisible":true}
// File_GetFolderName (filePath) : parentFolderPath
// File_GetFolderName (text) : text
// 
// DESCRIPTION
//   Given the path to a document, returns the path
//   to the folder the document is in.
//
C_TEXT:C284($1; $t_docPath)  //   Full path to document 
C_TEXT:C284($0; $t_folderPath)  //   Path to folder document is in
// ----------------------------------------------------
// HISTORY
//   Created by: Jeremy Sullivan (10/16/2001)
//   Mod: DB (11/20/07) - Improved and simplified
//   Mod by: Dani Beaubien (10/14/2012) - Worked around compiler bug
// ----------------------------------------------------

$t_docPath:=$1
$t_folderPath:=$t_docPath  // be default

C_LONGINT:C283($l_length; $l_position)
$l_position:=0
$l_length:=Length:C16($t_docPath)

C_TEXT:C284($vt_directorySymbol)
$vt_directorySymbol:=Folder separator:K24:12

If ($l_length>2)
	C_LONGINT:C283($i)
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

$0:=$t_folderPath
